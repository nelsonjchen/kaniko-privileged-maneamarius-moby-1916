# Workaround for [Moby #1916, no "--priviledged" option for `docker build`](https://github.com/moby/moby/issues/1916)

[**See the Dockerfile in *this repo* being built on Azure Pipelines @ ![Build Status](https://dev.azure.com/nelsonjchen/kaniko-privileged-maneamarius-moby-1916/_apis/build/status/nelsonjchen.kaniko-privileged-maneamarius-moby-1916?branchName=master)!**](https://dev.azure.com/nelsonjchen/kaniko-privileged-maneamarius-moby-1916/_build/latest?definitionId=8?branchName=master)

---

This is a demo using [Kaniko][kaniko] to build a Docker image with the Go compiler inside a
Gentoo image with the `--cap-add=SYS_PTRACE` option. It uses the exact
[Dockerfile from maneamarius who commented in the moby issue with an example][maneamarius-docker] to demonstrate the Kaniko workaround.

By no means is this limited to `--cap-add=SYS_PTRACE`. You can add whatever
is desired that you can normally add to `docker run` so `--priviledged` is
possible.

## Usage

### Fail ❌

`./build-docker-fail.sh` shows `docker` commands that aren't enough and `docker`
commands that don't exist to build [maneamarius's Dockerfile][maneamarius-docker].

```
# ./build-docker-fail.sh
```

### Win ✅

`./build-kaniko-win.sh` shows using [Kaniko][kaniko] to build
[maneamarius's Dockerfile][maneamarius-docker]. It puts it out to a tarball
that is then `docker load`'ed into the Docker instance. Then, this imported
image is used to run `go version`.

```
# ./build-kaniko-win.sh
```

It's not all sweet though. Golang, while apparently lovely for making rather
powerful single executable is anything but that itself as a build chain. There's
also package manager crap left around like many of us Docker users did when we
were Docker newbies. Kaniko cannot use overlayfs and the high amount of files does make its performance slower. The build time tax is higher for these sloppy
`Dockerfile`s as it normally tarballs every `RUN` for its layer.

For demonstration purposes, the `--snapshot` argument was passed to Kaniko to
effectively "squash" the `RUN`s down in the Dockerfile to save time by only
tarballing once at the end. **`--snapshot` isn't required**.

## Explanation

Building the Go compiler requires `PTRACE_TRACEME` support.

However, `docker build` does not support passing capabilities to the build
environment:

https://github.com/moby/moby/issues/1916

So, a workaround here is to build with [Google's Kaniko][kaniko]. Kaniko is
intended to run via a `docker run` and does not use a nested Docker and thus
does not require privileged operations. Because of this use of `docker run`,
we can also *grant it more privileged operations* and add `-cap-add=SYS_PTRACE`.


[kaniko]: https://github.com/GoogleContainerTools/kaniko
[maneamarius-docker]: https://github.com/moby/moby/issues/1916#issuecomment-361175319

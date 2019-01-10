# Workaround for [Moby #1916, no "--priviledged" option for `docker build`](https://github.com/moby/moby/issues/1916#issuecomment-361175319)

This is a demo using [Kaniko][kaniko] to build the Go compiler inside a
Gentoo image with the `--cap-add=SYS_PTRACE` option. It uses the exact
[Dockerfile from maneamarius of the moby issue][maneamarius-docker] to
demonstrate the Kaniko workaround.

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
# ./build-docker-fail.sh
```

It's not all sweet though. Golang, while apparently lovely for making rather
powerful single executable is anything but that itself as a build chain. There's
also package manager crap left around like many of us Docker users did when we
were newbies. Kaniko cannot use overlayfs and the high amount of files does make
its performance slower. The build time tax is higher for these sloppy
`Dockerfile`s.

For demonstration purposes, the `--snapshot` argument was passed to Kaniko to
effectively "squash" the `RUN`s down in the Dockerfile to save time.
*It isn't required*.

## Explanation

Building the Go compiler requires `PTRACE_TRACEME` support.

However, `docker build` does not support passing capabilities to the build
environment:

https://github.com/moby/moby/issues/1916

So, a workaround here is to build with [Google's Kaniko][kaniko]. Kaniko is
intended to run via a `docker run` and does not use a nested Docker and thus
does not require privileged operations. Because of this use of `docker run`,
we can also *grant it more privileged operations* and add `-cap-add=SYS_PTRACE`.


[kaniko]:https://github.com/GoogleContainerTools/kaniko
[maneamarius-docker]:(https://github.com/moby/moby/issues/1916#issuecomment-361175319).

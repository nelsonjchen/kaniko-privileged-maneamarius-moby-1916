# https://github.com/moby/moby/issues/1916#issuecomment-361175319

An experiment using kaniko to build the Go compiler inside some Gentoo image.

## Explanation

Building the Go compiler apparently requires `PTRACE_TRACEME` support.

However, `docker build` does not support passing capabilities to the build
environment:

https://github.com/moby/moby/issues/1916

So, perhaps a workaround here is to build with [Kaniko][kaniko]. Kaniko is intended to
run via a `docker run` and does not use a nested Docker. Since it uses `docker
run`, maybe we can add `-cap-add=SYS_PTRACE`.


[kaniko]:https://github.com/GoogleContainerTools/kaniko

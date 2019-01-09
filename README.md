# Workaround for [Moby](https://github.com/moby/moby/issues/1916#issuecomment-361175319)

*aka. the missing docker build --priviledged option*

An demo using kaniko to build the Go compiler inside some Gentoo image with the
`--cap-add=SYS_PTRACE` option.

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

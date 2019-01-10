#!/bin/bash

set -x

## This isn't enough.
docker build . -t maneamarius-gentoo-go
## Doesn't exist
docker build --privileged . -t maneamarius-gentoo-go
## Also doesn't exist
docker build --cap-add=SYS_PTRACE . -t maneamarius-gentoo-go

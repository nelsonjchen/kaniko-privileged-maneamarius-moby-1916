#!/bin/bash

set -ex

docker run \
  --cap-add=SYS_PTRACE \
  --rm \
  -v $(pwd):/workspace \
  gcr.io/kaniko-project/executor:v0.7.0 \
  --context dir:///workspace/ \
  --cache-dir=/workspace/cache \
  --context=/workspace \
  --tarPath=/workspace/maneamarius-gentoo-go.tar \
  --destination=maneamarius-gentoo-go \
  --single-snapshot
docker load -i maneamarius-gentoo-go.tar
docker run --rm maneamarius-gentoo-go go version

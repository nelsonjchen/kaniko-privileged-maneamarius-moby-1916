#!/bin/bash
set -ex

mkdir -p cache
docker run -v $(pwd):/workspace \
gcr.io/kaniko-project/warmer:v0.10.0 \
--cache-dir=/workspace/cache \
--image=gentoo/stage3-amd64:20190110 \
--image=alpine

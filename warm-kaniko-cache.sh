#!/bin/bash

docker run -v $(pwd):/workspace \
gcr.io/kaniko-project/warmer:latest \
--cache-dir=/workspace/cache \
--image=gentoo/stage3-amd64 \
--image=alpine

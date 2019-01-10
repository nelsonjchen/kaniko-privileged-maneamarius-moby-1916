#!/bin/bash

set -ex

docker run \
--cap-add=SYS_PTRACE \
--rm \
-v $(pwd)/cache:/cache \
-v $(pwd):/workspace \
gcr.io/kaniko-project/executor:latest \
--context dir:///workspace/ \
--cache-dir=/cache \
--context=/workspace \
--tarPath=/workspace/test.tar \
--destination=test \
--single-snapshot
docker import -i test.tar

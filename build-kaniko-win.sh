#!/bin/sh

docker run --cap-add=SYS_PTRACE --rm -v $(pwd):/workspace gcr.io/kaniko-project/executor:latest --dockerfile=Dockerfile --context=/workspace --no-push --tarPath=/workspace/test.tgz

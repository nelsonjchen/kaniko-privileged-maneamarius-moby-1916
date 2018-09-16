#!/bin/sh

docker run --cap-add=SYS_PTRACE --rm -v $(pwd):/workspace gcr.io/kaniko-project/executor:latest --dockerfile=Dockerfile --context=/workspace --tarPath=/workspace/test.tar --destination=test
docker import test.tar test
rm test.tar

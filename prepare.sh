#!/bin/bash
#set -e
docker run \
  --name env-corrupt3 \
  --env-file=env.txt \
  -v $(pwd)/foo.txt.md5:/foo.txt.md5 \
  -v $(pwd)/foo-mod.txt.md5:/foo-mod.txt.md5 \
  -v $(pwd)/../gojq:/usr/bin/gojq \
  --rm \
  --entrypoint /bin/bash \
  -it \
  nginx:1.21.5
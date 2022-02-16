#!/bin/bash
#set -e
docker run \
  --name env-corrupt \
  --env-file=env.txt \
  -v $(pwd)/foo.txt.md5:/foo.txt.md5 \
  -v $(pwd)/foo-mod.txt.md5:/foo-mod.txt.md5 \
  -v $(pwd)/foo-q.txt.md5:/foo-q.txt.md5 \
  -v $(pwd)/foo-mod-q.txt.md5:/foo-mod-q.txt.md5 \
  --rm \
  env-corrupt:latest
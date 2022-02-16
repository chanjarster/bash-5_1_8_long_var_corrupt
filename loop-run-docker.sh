#!/bin/bash
#set -e
i=0
while true
do
  i=$((i+1))  
  echo "Docker run round $i"
  docker run \
    --name env-corrupt \
    --env-file=env.txt \
    --env RUN_ONCE=true \
    --env SLEEP_ON_FAIL=false \
    -v $(pwd)/foo.txt.md5:/foo.txt.md5 \
    -v $(pwd)/foo-mod.txt.md5:/foo-mod.txt.md5 \
    -v $(pwd)/foo-q.txt.md5:/foo-q.txt.md5 \
    -v $(pwd)/foo-mod-q.txt.md5:/foo-mod-q.txt.md5 \
    --rm \
    env-corrupt:latest
  
  sleep 1

done
#!/bin/bash
#set -e
i=0
while true
do
  i=$((i+1))  
  echo "Docker run round $i"
  docker run \
    --name long-var-corrupt \
    --env SLEEP_ON_FAIL=false \
    -v $(pwd):/tmp/ \
    --rm \
    long-var-corrupt:latest
  
  sleep 1

done
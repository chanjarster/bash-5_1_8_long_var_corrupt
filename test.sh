#!/bin/bash
#set -e

FOO=$(cat /tmp/foo.txt)

want_q_md5=$(cat /tmp/foo.txt.md5 | cut -d ' ' -f 1)
got_md5=$(echo "$FOO" | md5sum -b | cut -d ' ' -f 1)
if [[ "$got_md5" != "$want_q_md5" ]]; then
  echo "failed"
  echo "$FOO" > /tmp/foo-corrupt.txt
  fail=true
else
  echo "succeed"
fi
echo ''

if [[ "$fail" == "true" && "$SLEEP_ON_FAIL" = "true" ]]; then
  sleep 10d
fi

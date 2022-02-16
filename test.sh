#!/bin/bash
#set -e
i=0

want_md5=$(cat /foo.txt.md5 | cut -d ' ' -f 1)
want_q_md5=$(cat /foo-q.txt.md5 | cut -d ' ' -f 1)
want_mod_md5=$(cat /foo-mod.txt.md5 | cut -d ' ' -f 1)
want_mod_q_md5=$(cat /foo-mod-q.txt.md5 | cut -d ' ' -f 1)

while true
do
  i=$((i+1))
  if [[ $(expr $i % 100) = "0" ]]; then
    echo "round $i"
  fi
  
  fail=false

  msg_prefix="round $i"
  if [[ "$RUN_ONCE" == "true" ]]; then
    msg_prefix=""
  fi

  # test 1
  echo $FOO > /tmp/foo.txt
  if ! md5sum -c /foo.txt.md5 > /dev/null; then
    echo "$msg_prefix failed: case 1"
    fail=true
  fi

  # test 2
  got_md5=$(echo $FOO | md5sum -b | cut -d ' ' -f 1)
  if [[ "$got_md5" != "$want_md5" ]]; then
    echo "$msg_prefix failed: case 2"
    fail=true
  fi
  
  # test 3
  got_md5=$(echo $FOO | md5sum | cut -d ' ' -f 1)
  if [[ "$got_md5" != "$want_md5" ]]; then
    echo "$msg_prefix failed: case 3"
    fail=true
  fi

  # test 4
  FOO_MOD=$(echo $FOO | gojq tostring)
  echo $FOO_MOD > /tmp/foo-mod.txt
  if ! md5sum -c /foo-mod.txt.md5 > /dev/null ; then
    echo "$msg_prefix failed: case 4"
    fail=true
  fi

  # test 5
  FOO_MOD=$(echo $FOO | gojq tostring)
  got_md5=$(echo $FOO_MOD | md5sum -b | cut -d ' ' -f 1)
  if [[ "$got_md5" != "$want_mod_md5" ]]; then
    echo "$msg_prefix failed: case 5"
    fail=true
  fi

  # test 6
  FOO_MOD=$(echo "$FOO" | gojq tostring)
  echo "$FOO_MOD" > /tmp/foo-mod-q.txt
  if ! md5sum -c /foo-mod-q.txt.md5 > /dev/null ; then
    echo "$msg_prefix failed: case 6"
    fail=true
  fi

  # test 7
  FOO_MOD=$(echo "$FOO" | gojq tostring)
  got_md5=$(echo "$FOO_MOD" | md5sum -b | cut -d ' ' -f 1)
  if [[ "$got_md5" != "$want_mod_q_md5" ]]; then
    echo "$msg_prefix failed: case 7"
    fail=true
  fi

  # test 8
  got_md5=$(echo "$FOO" | gojq tostring | md5sum | cut -d ' ' -f 1)
  if [[ "$got_md5" != "$want_mod_q_md5" ]]; then
    echo "$msg_prefix failed: case 8"
    fail=true
  fi

  if [[ "$RUN_ONCE" == "true" ]]; then
    if [[ "$fail" == "true" ]]; then
      if [[ "$SLEEP_ON_FAIL" = "true" ]]; then
        sleep 10d
      fi
      echo ''
      break
    else
      echo 'succeed'
      echo ''
      break
    fi
  else
    if [[ "$fail" == "true" ]]; then
      if [[ "$SLEEP_ON_FAIL" = "true" ]]; then
        sleep 10d
      fi
      echo ''
      sleep 1
    else
      echo 'succeed'
      echo ''
      sleep 1
    fi
  fi
done
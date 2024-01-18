#!/usr/bin/env bash
find "$@" -print0 \
| sort -z \
| tar -cvf - \
      --mtime='@0' \
      --owner=0 --group=0 --numeric-owner \
      --pax-option=exthdr.name=%d/PaxHeaders/%f,delete=atime,delete=ctime,delete=mtime \
      --format=posix \
      --mode="go-rwx,u-rw" \
      --no-recursion \
      --null \
      --files-from -

#!/usr/bin/env bash

set -e

for branch in $(git branch | tr '*' ' '); do
  if [ -z "$(git log -1 --since='1 month ago' -s $branch)" ]; then
    echo $branch
  fi
done

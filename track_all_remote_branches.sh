#!/usr/bin/env bash

set -e

localBranchExists() {
  prefix=origin/
  branch_name=${1#$prefix}
  git show-ref --verify --quiet "refs/heads/$branch_name"
}

git fetch --all -p --quiet

# Tracking all remote branches
git branch -r | grep -vE 'HEAD|master' | while read remote;
  do
    if ! localBranchExists $remote; then
      git branch --track "${remote#origin/}" "$remote" --quiet
    fi
done

git pull --all --quiet

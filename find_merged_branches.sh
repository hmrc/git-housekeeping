#!/usr/bin/env bash

set -e

SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
"$SCRIPT_DIR/track_all_remote_branches.sh"

for b in $(git branch --merged master | tr '*' ' ' | grep -v master); do
    echo $b
done

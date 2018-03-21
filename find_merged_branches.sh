#!/usr/bin/env bash

set -e

SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
"$SCRIPT_DIR/track_all_remote_branches.sh"

for b in $(git branch -r --merged origin/master |  grep origin | grep -v 'master' | cut -d/ -f2-); do
    echo $b
done

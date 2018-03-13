#!/usr/bin/env bash

set -e

SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
$SCRIPT_DIR/find_merged_branches.sh
$SCRIPT_DIR/find_old_branches.sh


# shows branches that will remain
# cd your-repo-dir
# grep -F -v -f <(./find_unnecessary_branches.sh) <(git branch -r)

#!/usr/bin/env bash

set -e

usage() {
  echo
  echo "Deletes no longer needed branches"
  echo
  echo "Following options are supported: "
  echo
  echo " -d or --dry-run see what would be deleted"
  echo
  echo " -l or --remove-local to remove local branches"
  echo
  echo " -r or --remove-remote to remove remote branches"
  echo
  echo " -o or --older-than to specify how old branches can be, defaults to --older-than '1 month ago'"
  echo "  see here for supported date formats: https://stackoverflow.com/questions/19742345/what-is-the-format-for-date-parameter-of-git-commit/19742762#19742762"
  echo
  echo
}

DRY_RUN=""
REMOVE_LOCAL=""
REMOVE_REMOTE=""
OLDER_THAN="1 month ago"

while [[ $# -gt 0 ]]
do
  cla="$1"
  shift
  case $cla in
    -l|--remove-local)
    REMOVE_LOCAL=true
    ;;
    -r|--remove-remote)
    REMOVE_REMOTE=true
    ;;
    -d|--dry-run)
    DRY_RUN=true
    ;;
    -o|--older-than)
    OLDER_THAN="$1"
    shift;;
    *)
    echo
    echo "Unrecognised option $cla"
    usage
    exit 1;;
  esac
done

remove_local_branch() {
  if [ -n "$REMOVE_LOCAL" ]; then
    if [ -n "$DRY_RUN" ]; then
      echo "(dry run) deleting local branch: $branch"
    else
      git branch -D "$1"
    fi
  fi
}

remove_remote_branch() {
  if [ -n "$REMOVE_REMOTE" ]; then
    if [ -n "$DRY_RUN" ]; then
      echo "(dry run) deleting remote branch: $branch"
    else
      git push origin --delete "$1"
    fi
  fi
}


SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

"$SCRIPT_DIR"/all_unnecessary_branches.sh | while read branch; do
  if [[ "$branch" =~ main ]]; then
    echo "skipping branch: $branch"
  else
    remove_local_branch "$branch"
    remove_remote_branch "$branch"
  fi
done

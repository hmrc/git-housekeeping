
# git-housekeeping

Set of scripts to help keep git repositories in good order.

## Remove no longer needed branches

no longer needed = already merged to master or last commit older than specified time reference (1 month ago by default)

```
cd your-git-repository
$SCRIPTS_DIR/remove_branches.sh --remove-local --remove-remote
```

specify explicitly how old branches can be
```
cd your-git-repository
$SCRIPTS_DIR/remove_branches.sh --remove-local --remove-remote --older-than '3 months ago'
```

dry run (prints what would be deleted)
```
cd your-git-repository
$SCRIPTS_DIR/remove_branches.sh --dry-run --remove-local --remove-remote
```

## Show branches that would remain

```
cd your-git-repository
grep -F -v -f <($SCRIPTS_DIR/all_unnecessary_branches.sh) <(git branch -r)
```

## Show branches merged to master

```
cd your-git-repository
$SCRIPTS_DIR/find_merged_branches.sh
```

## Show branches older than specified time reference
```
cd your-git-repository
$SCRIPTS_DIR/find_old_branches.sh --older-than '1 year ago'
```

### License

This code is open source software licensed under the [Apache 2.0 License]("http://www.apache.org/licenses/LICENSE-2.0.html").

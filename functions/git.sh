# Git Worktree Helpers

function cdw {
  local worktree_name=$1
  local worktree_path
  
  if [ -z "$worktree_name" ]; then
    worktree_name=$(git worktree list | awk '{print $1}')
  fi
  
  worktree_path=$(git worktree list "$worktree_name" --porcelain | awk '{print $2}')
  
  if [ -z "$worktree_path" ]; then
    echo "Worktree not found: $worktree_name"
    return 1
  fi
  
  cd "$worktree_path"
}

function lsw {
  local worktree_name=$1
  
  if [ -z "$worktree_name" ]; then
    worktree_name=$(git worktree list | awk '{print $1}')
  fi
  
  if [ -z "$worktree_name" ]; then
    echo "No worktree specified"
    return 1
  fi
  
  git worktree list "$worktree_name" --porcelain | awk '{print $2}'
  ls "$worktree_name"
}

# Git Stash Helpers

function gspop {
  local n=$1
  
  if [ -z "$n" ]; then
    n="0"
  fi
  
  git stash pop stash@{$n}
}

function gsapply {
  local n=$1
  
  if [ -z "$n" ]; then
    n="0"
  fi
  
  git stash apply stash@{$n}
}

function gsshow {
  local n=$1
  
  if [ -z "$n" ]; then
    n="0"
  fi
  
  git stash show stash@{$n}
}

function gsshowpatch {
  local n=$1
  
  if [ -z "$n" ]; then
    n="0"
  fi
  
  git stash show -p stash@{$n}
}

function gsdrop {
  local n=$1
  
  if [ -z "$n" ]; then
    n="0"
  fi
  
  git stash drop stash@{$n}
}

function gprune {
  git remote prune origin \
    | grep pruned \
    | sed 's/.*origin\///' \
    | xargs git branch -d
}

function stashstaged {
  read -p "Warning! If you have any new files, this process may delete them. Would you like to continue? (y\n) " yn
  echo $yn | grep ^[Yy]$
  result=$?
  if [ $result -eq 1 ]; then
    exit 1
  fi
  git stash --keep-index && git stash -u && gspop 1 && git stash show -p | git apply -R
}

# Open a repo based on the current repo's origin remote.
function open-repo {
  repo=$(git config remote.origin.url);
  if [[ "$repo" =~ \.git$ ]]; then
    repo=${repo:0:$((${#repo}-4))};
  fi

  if [[ "$repo" =~ ^git@ ]]; then
    repo=$(awk -F: '{print $1"/"$2}' <<< "$repo");
    repo=$(awk -F@ '{print "https://"$2}' <<< "$repo");
  fi

  suffix=$1;
  if [ ! -z "$suffix" ]; then
    case "$suffix" in
      "p")
        suffix="pipelines"
        ;;
      "m")
        suffix="merge_requests"
        ;;
      "mr")
        suffix="merge_requests"
        ;;
      "c")
        suffix="settings/ci_cd#js-cicd-variables-settings"
        ;;
      "ci")
        suffix="settings/ci_cd#js-cicd-variables-settings"
        ;;
    esac
    suffix="-/$suffix";
    repo="${repo}/${suffix}"
  fi
  >&2 echo "Opening repo URL: ${repo}";
  open "$repo";
}

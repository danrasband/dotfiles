function gspop {
  local n=$1;

  if [ -z "$n" ]; then
    n="0";
  fi

  git stash pop stash@{$n};
}

function gsapply {
  local n=$1;

  if [ -z "$n" ]; then
    n="0";
  fi

  git stash apply stash@{$n};
}

function gsshow {
  local n=$1;

  if [ -z "$n" ]; then
    n="0";
  fi

  git stash show stash@{$n};
}

function gsdrop {
  local n=$1;
  if [ -z "$n" ]; then
    n="0";
  fi

  git stash drop stash@{$n};
}

function gprune {
  git remote prune origin | \
    grep pruned | \
    sed 's/.*origin\///' | \
    xargs git branch -d
}

function stashstaged {
  git stash --keep-index && git stash && gspop 1 && git stash show -p | git apply -R
}

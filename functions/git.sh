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

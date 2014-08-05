function popstash() {
  local n=$1
  if [ -z "$n" ]; then
    n="0";
  fi
  git stash pop stash@{$n};
}

function applystash {
  local n=$1
  if [ -z "$n" ]; then
    n="0";
  fi
  git stash apply stash@{$n};
}

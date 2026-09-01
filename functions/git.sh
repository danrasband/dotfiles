# Git Worktree Helpers

_worktree_dir() {
  git worktree list --porcelain 2>/dev/null | awk -v RS='' -v t="$1" '
    {
      path = ""; branch = ""
      n = split($0, lines, "\n")
      for (i = 1; i <= n; i++) {
        if (lines[i] ~ /^worktree /) path = substr(lines[i], 10)
        else if (lines[i] ~ /^branch /) {
          branch = substr(lines[i], 8)
          sub("refs/heads/", "", branch)
        }
      }
      base = path
      sub(/.*\//, "", base)
      if (branch == t || base == t) { print path; exit }
    }
  '
}

cdw() {
  local dir
  dir=$(_worktree_dir "$1")
  if [[ -z "$dir" ]]; then
    echo "Worktree ${1} does not exist." >&2
    return 1
  fi
  cd "$dir"
}

lsw() {
  local dir
  dir=$(_worktree_dir "$1")
  if [[ -z "$dir" ]]; then
    echo "Worktree ${1} does not exist." >&2
    return 1
  fi
  ls "$dir"
}

_cdw() {
  local -a candidates
  local wt_path wt_branch
  while IFS= read -r line; do
    case "$line" in
      worktree\ *) wt_path="${line#worktree }" ;;
      branch\ *)
        wt_branch="${line#branch }"
        wt_branch="${wt_branch#refs/heads/}"
        candidates+=("$wt_branch")
        ;;
      "") candidates+=("${wt_path:t}") ;;
    esac
  done < <(git worktree list --porcelain 2>/dev/null; echo)
  _describe 'worktree' candidates
}
compdef _cdw cdw lsw


## Git Stash Helpers

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

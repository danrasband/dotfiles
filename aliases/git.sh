alias gs="git status"
alias gf="git fetch -p"
alias gp="git pull"
alias ga="git add"
alias gc="git commit -v"
alias gl="git log"
alias gsl="git shortlog"
alias gd="git diff"

# Git flow stuff.
if [ -n `which git-flow` ]; then
  alias gffs="git flow feature start"
  alias gfff="git flow feature finish"
  alias gfrs="git flow release start"
  alias gfrf="git flow release finish"
  alias gfhs="git flow hotfix start"
  alias gfhf="git flow hotfix finish"
  alias gfss="git flow support start"
  alias gfsf="git flow support finish"
fi


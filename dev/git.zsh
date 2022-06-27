alias reset='git checkout -f'
alias changes='git diff'
alias last_commit='git diff HEAD^ HEAD'
alias tree="glog"
alias log="glog"
alias gllog="git lg -p"
alias push_amend='amend_push'
alias uncommit='git reset HEAD^'
alias delete_branch='remove_branch'
alias rm_branch='remove_branch'
alias remove_branch='gbrdm'

rename_branch() {
  git branch -m $1 $2
}

branch() {
  name=$1
  target=$2
  git fetch --all

  git checkout -b "$name" --no-track "origin/master"
}

feature() {
  default_team="nova"
  team="${2:-$default_team}"
  ticket=$1
  git fetch --all
  git checkout master
  git pull

  git checkout -b "${team:l}/${ticket:l}" --no-track "origin/master"
}

checkout() {
  git-branch-picker
}

rename_push() {
  if read -q "choice?Deseja remover a branch antiga? [Y/N]:"; then
      remove_branch $1
  else
      echo
      echo "Blz..."
      echo
  fi
  git branch -m $1
  git push --set-upstream -f -u origin $1
}

remote_branch() {
  name=$1
  remote=$2
  git fetch --all
  git checkout -b $name "$remote/$name"
}

update() {
  git checkout $1
  git fetch --all
  git pull rel $1
}

amend_message() {
  email=$(git config --get user.email)
  git add -A
  git commit --amend --author="Sergio Vilar <$email>"
}

amend() {
  email=$(git config --get user.email)
  git add -A
  git commit --amend --no-edit --author="Sergio Vilar <$email>"
}

commit() {
  git diff
  if read -q "choice?Deseja fazer o commit? [Y/N]:"; then
      git add -A
      git commit
  else
      echo
      echo "Blz..."
  fi
}

cherry_pick() {
  branch=$1
  current_branch=$(git rev-parse --abbrev-ref HEAD)
  commit=$(git rev-parse HEAD)
  echo "Checkouting $branch..."
  git checkout $branch
  echo "Cherry picking commit $commit from branch $current_branch into $branch"
  git cherry-pick $commit
}

cherry_pick_continue() {
  git cherry-pick --continue --no-edit
}

amend_push() {
  git diff
  if read -q "choice?Deseja fazer o amend e push -f? [Y/N]:"; then
      amend
      git push -f -u origin
  else
      echo
      echo "Blz..."
  fi
}

push() {
  current_branch=$(git rev-parse --abbrev-ref HEAD)
  git push -u origin $current_branch
}

rebase() {
  branch_name="$(git symbolic-ref HEAD 2>/dev/null)" ||
  branch_name="(unnamed branch)"
  branch_name=${branch_name##refs/heads/}

  git fetch --all
  git checkout $1
  git pull rel $1
  git checkout $branch_name
  git rebase $1
}

reset_file() {
  git checkout HEAD^ $1
}

branch_cleanup() {
  branches=()
  eval "$(git for-each-ref --shell --format='branches+=(%(refname:short))' refs/heads/)"
  for branch in "${branches[@]}"; do
      git for-each-ref --shell --format='%(refname:short)' refs/tags/ | grep "'v$branch'" | while read -r line ; do
        git branch -D $branch
    done
  done
}

git_help(){
  __usage="
  Helpers do Git:

    branch <branch> <target>          Cria uma branch a partir de uma branch remota
    checkout                          Abre mudança interativa entre branches
    remove_branch                     Apaga uma branch
    rename_push <novo nome>           Renomeia a branch atual
    remote_branch <target> <remote>   Cria uma branch a partir de um remote
    update <branch>                   Atualiza uma branch a partir do remote 'rel'
    amend                             Adiciona todas mudança e faz um git amend
    amend_message                     Adiciona todas mudança e faz um git amend com edição
    commit                            Adiciona todas mudança e faz um git commit
    cherry_pick <target>              Faz um cherry-pick da branch atual no target
    cherry_pick_continue              Continua um git cherry-pick
    amend_push                        Faz um amend e um push pro remote origin
    push                              Faz um push pro remote origin
    rebase <target>                   Faz um rebase da branch target
    branch_cleanup
  "
  echo "$__usage"
}

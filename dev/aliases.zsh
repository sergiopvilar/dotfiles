alias tower='gittower ./'

# Project aliases
alias cd_dev="cd /Users/sergio/rel/rpm"
alias run="cd_dev; script/develop"
alias sa_setup="project_setup sample"
alias su_setup="project_setup"
alias reset_vpn="ssh $DEVREMOTE -p 80"
alias rcleanup="cd $DEVPROJECT;branch_cleanup && review cleanup"
alias subl="/Applications/Sublime\ Text.app/Contents/SharedSupport/bin/subl"
alias code='$EDITOR'
alias rspec='bundle exec rspec'
alias rails='bundle exec rails'
alias rake='bundle exec rake'
alias docker_es='docker-compose up elasticsearch kibana'
alias es_index='rake rpm:elasticsearch_indexer\[all]'
alias rlsi_run='bundle exec shotgun -s thin --host 0.0.0.0'
alias ssh_add='ssh-add ~/.ssh/id_rsa'

project_setup() {
  cd_dev
  command="SSHUSER=$DEVUSER script/setup --database-user=rpm_db_user --database-password=trust"

  if [[ $1 == "sample" ]]
    then
      command="${command} --sample --customer=sit"
      eval $command
    else
      command="${command} -r --ssh-user=$DEVUSER"
      eval $command
      bundle exec rails runner $HOME/.dotfiles/dev/scripts/su.rb
    fi
}

# Project functions
nodes_import() {
  rails runner $HOME/.dotfiles/dev/scripts/es_import.rb $1
}

create_prop() {
  bundle exec rails runner $HOME/.dotfiles/dev/scripts/sample_property.rb $1 $2
}

branch() {
  name=$1
  target=$2
  git fetch --all
  git checkout -b "progress/$name" --no-track "rel/$target"
}

update() {
  git checkout $1
  git fetch --all
  git pull rel $1
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

branch_cleanup() {
  branches=()
  eval "$(git for-each-ref --shell --format='branches+=(%(refname:short))' refs/heads/)"
  for branch in "${branches[@]}"; do
      git for-each-ref --shell --format='%(refname:short)' refs/tags/ | grep "'v$branch'" | while read -r line ; do
        git branch -D $branch
    done
  done
}

# Tool aliases
alias php_server='php -S localhost:3000'
alias postgres_kill="ps aux | grep postgres | grep idle | awk '{print $2}' | xargs kill"
alias rails_run="bundle exec rails server"
alias cde="code ./"
alias glog="git lg"
alias gllog="git lg -p"

# Tool Functions
pgclean() {
  echo "Removing .pid files..."
  sudo rm /usr/local/Evar/postgres/postmaster.pid
  sudo rm /usr/local/var/postgres/postmaster.pid
  echo "Restarting Postgres..."
  brew services restart postgresql
}

ssl_pf() {
  ssh -L "$1":localhost:443 $2
}

docker_run() {
  cd_dev
  $DEVPROJECT/devtools/setup
  PINPAD_SIMULATION_ENABLED=0 docker-compose -f $DEVPROJECT/devtools/rje-env/docker-compose.yml up rabbitmq sit0001red0
}

alias docker_cleanup_rel="docker images | grep reliant.io | awk '{print $3}' | xargs docker rmi"
alias docker_cleanup_none="docker images | grep '<none>' | awk '{print $3}' | xargs docker rmi"
alias docker_cleanup_images="docker images | awk '{print $3}' | xargs docker rmi"

docker_purge() {
  echo "Stopping and removing containers..."
  docker_cleanup
  echo "Removing all images..."
  docker_cleanup_images
  echo "Pruning remaining objects..."
  docker system prune --all -f
  echo "Done."
}

docker_cleanup() {
  docker stop $(docker ps -a -q)
  docker rm $(docker ps -a -q)
}

cleanup() {
  docker_purge;
  sudo pmset -a hibernatemode 0; sudo rm /var/vm/sleepimage;
}

# Dotfiles help
alias_help() {
  echo "PROJECT ALIASES\n---------------"
  echo "cd_dev:           cds into $DEVPROJECT"
  echo "run:              runs script/develop into $DEVPROJECT"
  echo "sa_setup:         runs script/setup as sample into $DEVPROJECT"
  echo "su_setup:         runs script/setup with prod data and as admin into $DEVPROJECT"
  echo "reset_vpn:        resets VPN password"
  echo "rpush:            runs reviewit push at $DEVPROJECT"
  echo "rcleanup:         remove released branches merged MRs at $DEVPROJECT"
  echo "branch:           <branch name> <version> creates a branch from a version"

  echo "\nTOOL ALIASES\n-----------"
  echo "php_server:       runs a Php server at current directory"
  echo "postgres_kill:    kills all PostgreSQL processes"
  echo "postgres_clean:   cleans old postmaster.pid files"
  echo "docker_run:       runs docker with project configurations at $DEVPROJECT"
  echo "docker_cleanup:   stop and removes all docker containers"
}
alias aliases_help='alias_help'

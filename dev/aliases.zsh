alias tower='gittower ./'

# Project utils
alias cd_dev="cd $DEVPROJECT"
alias run="cd_dev && $DEVPROJECT/script/develop"
alias sa_setup="cd_dev && SSHUSER=$DEVUSER $DEVPROJECT/script/setup --sample --customer=sit"
alias su_setup="cd_dev && SSHUSER=$DEVUSER $DEVPROJECT/script/setup -r --ssh-user=$DEVUSER; bundle exec rails runner $HOME/.dotfiles/dev/su.rb"
alias reset_vpn="ssh $DEVREMOTE -p 80"
alias rpush="cd_dev && review push"
alias rcleanup="cd $DEVPROJECT;branch_cleanup && review cleanup"

# Php utils
alias php_server='php -S localhost:3000'

# Postgres Utils
alias postgres_kill="ps aux | grep postgres | grep idle | awk '{print $2}' | xargs kill"
postgres_clean() {
  sudo rm /usr/local/Evar/postgres/postmaster.pid
  sudo rm /usr/local/var/postgres/postmaster.pid
}

# Docker Utils
docker_run() {
  cd_dev
  $DEVPROJECT/devtools/setup
  PINPAD_SIMULATION_ENABLED=0 docker-compose -f $DEVPROJECT/devtools/rje-env/docker-compose.yml up rabbitmq sit0001red0
}

docker_cleanup() {
  docker stop $(docker ps -a -q)
  docker rm $(docker ps -a -q)
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

alias_help() {
  echo "PROJECT ALIASES\n---------------"
  echo "cd_dev:           cds into $DEVPROJECT"
  echo "run:              runs script/develop into $DEVPROJECT"
  echo "sa_setup:         runs script/setup as sample into $DEVPROJECT"
  echo "su_setup:         runs script/setup with prod data and as admin into $DEVPROJECT"
  echo "reset_vpn:        resets VPN password"
  echo "rpush:            runs reviewit push at $DEVPROJECT"
  echo "rcleanup:         remove released branches merged MRs at $DEVPROJECT"

  echo "\nTOOL ALIASES\n-----------"
  echo "php_server:       runs a Php server at current directory"
  echo "postgres_kill:    kills all PostgreSQL processes"
  echo "postgres_clean:   cleans old postmaster.pid files"
  echo "docker_run:       runs docker with project configurations at $DEVPROJECT"
  echo "docker_cleanup:   stop and removes all docker containers"
}

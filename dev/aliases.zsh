alias tower='gittower ./'

# Project utils
alias run="cd $DEVPROJECT;script/develop"
alias setup_sample="cd $DEVPROJECT;SSHUSER=$DEVUSER script/setup --sample"
alias su_setup="cd $DEVPROJECT;SSHUSER=$DEVUSER script/setup -r --ssh-user=$DEVUSER; bundle exec rails runner $HOME/.dotfiles/dev/su.rb"
alias reset_vpn="ssh $DEVREMOTE -p 80"
alias rpush="cd $DEVPROJECT;review push"

# Php utils
alias php_server='php -S localhost:3000'

# Postgres Utils
alias postgres_kill="ps aux | grep postgres | grep idle | awk '{print $2}' | xargs kill"
postgres_clean() {
  sudo rm /usr/local/Evar/postgres/postmaster.pid
  sudo rm /usr/local/var/postgres/postmaster.pid
}

# Docker Utils
docker_cleanup() {
  docker stop $(docker ps -a -q)
  docker rm $(docker ps -a -q)
}

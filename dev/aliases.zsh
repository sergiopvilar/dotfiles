alias tower='gittower ./'

# Other Alias
alias run="cd $DEVPROJECT && script/develop"
alias setup="cd $DEVPROJECT && SSHUSER=$DEVUSER script/setup"
alias kill_idle="ps aux | grep postgres | grep idle | awk '{print $2}' | xargs kill"
alias su_setup="cd $DEVPROJECT && SSHUSER=$DEVUSER script/setup -r --ssh-user=$DEVUSER --superuser=$DEVUSER"
alias tempo='curl -4 http://wttr.in/Jo%C3%A3o%20Pessoa?lang=pt'

clean_postgres() {
  sudo rm /usr/local/Evar/postgres/postmaster.pid
}

docker_cleanup() {
  docker stop $(docker ps -a -q)
  docker rm $(docker ps -a -q)
}

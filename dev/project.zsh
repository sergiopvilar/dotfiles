alias cd_dev="cd /home/sergio/rel/rpm"
alias run="cd_dev; script/develop --redis-port=6380"
alias sa_setup="project_setup sample"
alias su_setup="project_setup"
alias docker_es='sudo docker-compose up elasticsearch kibana'
alias es_index='rake rpm:elasticsearch_indexer\[all]'
alias rlsi_run='bundle exec shotgun -s thin --host 0.0.0.0'
alias rcleanup="cd $DEVPROJECT;branch_cleanup && review cleanup"

alias sa_setup="project_setup sample"
alias su_setup="project_setup"
alias cd_dev="cd /home/sergio/rel/rpm"

su_setup_backup() {
  cd_dev
  command="SSHUSER=$DEVUSER script/setup --database-user=rpm_db_user --database-password=trust"
  command="${command} -r --ssh-user=$DEVUSER $1"
  eval $command
  bundle exec rails runner $HOME/.dotfiles/dev/scripts/su.rb
}

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

vpn_reliant() {
  sudo vpnc reliant
  sudo route del default dev tun0
  sudo route add -net 10.250.251.0 netmask 255.255.255.0 dev tun0
  sudo route add -net 10.250.250.0 netmask 255.255.255.0 dev tun0
  sudo route add -net 10.250.254.0 netmask 255.255.255.0 dev tun0
  sudo route add -net 10.250.230.0 netmask 255.255.255.0 dev tun0
  sudo route add -net 10.250.240.0 netmask 255.255.255.0 dev tun0
  sudo route add -net 10.0.0.0 netmask 255.255.255.0 dev tun0
  sudo route add -net 10.0.1.0 netmask 255.255.255.0 dev tun0
  sudo route add -net 10.99.99.0 netmask 255.255.255.0 dev tun0
}

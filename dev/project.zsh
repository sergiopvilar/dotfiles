alias cd_dev="cd /home/sergio/rel/rpm"
alias run="cd_dev; script/develop --redis_port 6380"
alias sa_setup="project_setup sample"
alias su_setup="project_setup"
alias docker_es='sudo docker-compose up elasticsearch kibana'
alias es_index='rake rpm:elasticsearch_indexer\[all]'
alias rlsi_run='bundle exec shotgun -s thin --host 0.0.0.0'
alias rcleanup="cd $DEVPROJECT;branch_cleanup && review cleanup"

alias sa_setup="project_setup sample"
alias su_setup="project_setup"
alias cd_dev="cd /home/sergio/rel/rpm"
alias dec_1="dec_foreman"
alias dec_3="dec_portal"
alias dec_4="dec_pricing"

export DECPATH="/home/sergio/Decisiv"

dec_foreman(){
  echo "STARTING POSTGRESQL\n"
  sudo service postgresql start
  echo "----------------\n"
  echo "STARTING FOREMAN\n"
  echo "----------------\n"
  cd $DECPATH
  foreman start
}

panaceia() {
  bundle exec rake db:structure:load --trace
  bundle exec rake db:migrate
  bundle exec rake parallel:migrate
}

dec_2(){
  dec_services
  dec_vpn
}

dec_portal() {
  echo "STARTING PORTAL\n"
  echo "---------------\n"
  cd $DECPATH/portal
  bundle exec rails s -p 3000
}

dec_pricing() {
  echo "STARTING PRICING\n"
  echo "---------------\n"
  cd $DECPATH/pricing
  bundle exec rails s -p 3001
}

dec_services() {
  cd $DECPATH
  echo "STARTING DECISIV SERVICES\n"
  echo "-------------------------\n"
  rvm use 2.4.10
  services start
  services bootstrap
  services update_all qa
  services list
}

dec_vpn(){
  echo "STARTING DECISIV VPN\n"
  echo "---------------------\n"
  tsh --proxy=decisiv.sh:443 login --auth=okta
  sudo openvpn ~/vpn/qa.ovpn
}

docker_packages() {
  cd_dev
  ./devtools/setup
  git submodule update --init --recursive
  sudo docker-compose -f devtools/rje-env/docker-compose.yml up rabbitmq sit0001red0
}

su_setup_backup() {
  cd_dev
  command="SSHUSER=$DEVUSER script/setup --database-password=trust"
  command="${command} -r --ssh-user=$DEVUSER $1"
  eval $command
  bundle exec rails runner $HOME/.dotfiles/dev/scripts/su.rb
}

rlsi_password() {
  cat ~/cridx.db_key | grep ^$1:
}

project_setup() {
  cd_dev
  command="SSHUSER=$DEVUSER script/setup --database-password=trust"

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

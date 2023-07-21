alias tower='gittower ./'
alias reset_vpn="ssh vpn-tlh.reliant.io -p 80"
alias subl="/Applications/Sublime\ Text.app/Contents/SharedSupport/bin/subl"
alias code='$EDITOR'
alias rspec='bundle exec rspec'
alias rake='bundle exec rake'
alias ssh_add='ssh-add ~/.ssh/id_rsa'
alias php_server='php -S localhost:3000'
alias postgres_kill="ps aux | grep postgres | grep idle | awk '{print $2}' | xargs kill"
alias rails_run="bundle exec rails server"
alias cde="code ./"
alias edit_password="sudo nano /etc/vpnc/reliant"

# Tool Functions
pgclean() {
  echo "Removing .pid files..."
  sudo rm /usr/local/Evar/postgres/postmaster.pid
  sudo rm /usr/local/var/postgres/postmaster.pid
  echo "Restarting Postgres..."
  brew services restart postgresql
}

postgres_help() {
  psql -t -P format=unaligned -c 'show hba_file';
}

scp_download(){
  scp $server:$file ./
}

ssl_pf() {
  ssh -L "$1":localhost:443 $2
}

vpn_stop() {
  sudo killall vpnc
}

activate_vscode() {
  xdotool search --name "Visual Studio Code" | head -1 | xargs xdotool windowactivate
}

dynamic_spaces() {
  gsettings set org.gnome.mutter dynamic-workspaces true
}

fixed_spaces() {
  gsettings set org.gnome.mutter dynamic-workspaces false
}

space_number() {
  gsettings set org.gnome.desktop.wm.preferences num-workspaces $1
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
  echo "docker_cleanup:   stop and removes all docker containers"
}
alias aliases_help='alias_help'

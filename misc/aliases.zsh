alias tempo='curl -4 "http://wttr.in/Jo%C3%A3o%20Pessoa?lang=pt"'

purge_space() {
  docker_purge
  sudo rm -rf ~/Downloads/* -y
  sudo rm -rf /Users/sergio/Library/Caches/* -y
  sudo rm -rf /Users/sergio/Library/Application Support/Steam/* -y
}

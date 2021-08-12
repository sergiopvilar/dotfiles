alias docker_cleanup_rel="docker images | grep reliant.io | awk '{print $3}' | xargs docker rmi"
alias docker_cleanup_none="docker images | grep '<none>' | awk '{print $3}' | xargs docker rmi"
alias docker_cleanup_images="sudo docker images | awk '{print $3}' | xargs sudo docker rmi"

docker_run() {
  cd_dev
  $DEVPROJECT/devtools/setup
  PINPAD_SIMULATION_ENABLED=0 docker-compose -f $DEVPROJECT/devtools/rje-env/docker-compose.yml up rabbitmq sit0001red0
}

docker_purge() {
  echo "Stopping and removing containers..."
  docker_cleanup
  echo "Removing all images..."
  docker_cleanup_images
  echo "Pruning remaining objects..."
  sudo docker system prune --all -f
  echo "Done."
}

docker_cleanup() {
  sudo docker stop $(sudo docker ps -a -q)
  sudo docker rm $(sudo docker ps -a -q)
}

cleanup() {
  docker_purge;
  sudo pmset -a hibernatemode 0; sudo rm /var/vm/sleepimage;
}

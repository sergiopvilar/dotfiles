#!/usr/bin/env bash

if [ "$(uname)" == "Linux" ]; then
  sudo apt-get install golang-go postgresql -y
  sudo /etc/init.d/postgresql restart
  sudo -u postgres createuser -s $(whoami); createdb $(whoami); exit 0
  go get -u github.com/justjanne/powerline-go
fi

psql -d template1 -c 'create extension hstore;'; exit 0

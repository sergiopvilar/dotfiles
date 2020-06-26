#!/usr/bin/env bash

if [ "$(uname)" == "Linux" ]; then
  sudo add-apt-repository ppa:lazygit-team/release
  sudo apt-get update
  sudo apt-get install golang-go unzip lazygit bat -y
  go get -u github.com/justjanne/powerline-go
fi

if [ "$(uname)" == "Darwin" ]; then
  brew install bat lazygit
fi

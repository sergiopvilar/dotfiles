#!/usr/bin/env bash

if [ "$(uname)" == "Linux" ]; then
  sudo apt-get update
  sudo apt-get install golang-go unzip bat -y
  go get -u github.com/justjanne/powerline-go
fi

if [ "$(uname)" == "Darwin" ]; then
  brew install bat lazygit
fi

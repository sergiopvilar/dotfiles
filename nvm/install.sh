#!/bin/sh

if test ! $(which fnm)
then
  wget -O ./fnm-install.sh https://github.com/Schniz/fnm/raw/master/.ci/install.sh
  chmod +x ./fnm-install.sh
  ./fnm-install.sh --force-install
  rm ./fnm-install.sh
  source "$HOME/.dotfiles/nvm/path.zsh"
  fnm install latest
  fnm default latest

  if test "$(uname)" = "Linux"
  then
    curl -o- -L https://yarnpkg.com/install.sh | bash
  fi
fi

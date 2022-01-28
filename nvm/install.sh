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

if test ! $(which git-checkout)
then
  npm install -g git-checkout
fi

if test ! $(which tldr)
then
  npm install -g tldr
fi

if test ! $(which gtop)
then
  npm install -g gtop
fi

if test ! $(which git-branch-delete)
then
  npm install -g git-branch-delete
fi

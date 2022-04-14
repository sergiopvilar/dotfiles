#!/bin/sh

echo "Installing node version manager..."

if test ! $(which fnm)
then
  wget -O ./fnm-install.sh https://github.com/Schniz/fnm/raw/master/.ci/install.sh
  chmod +x ./fnm-install.sh
  ./fnm-install.sh --force-install
  rm ./fnm-install.sh
  source "$HOME/.dotfiles/nvm/path.zsh"
  fnm install v16.13.0
  fnm default v16.13.0

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

if test ! $(which git-branch-picker)
then
  npm install -g git-branch-picker
fi

if test ! $(which gbrdm)
then
  npm install -g gbrdm
fi

if test -z ${WSL_DISTRO_NAME}
then
  echo "Not installing wsl-open..."
else
  if test ! $(which wsl-open)
  then
    npm install -g wsl-open
  fi
fi

exit 0

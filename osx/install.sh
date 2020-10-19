#!/usr/bin/env bash

# The Brewfile handles Homebrew-based app and library installs, but there may
# still be updates and installables in the Mac App Store. There's a nifty
# command line interface to it that we can use to just install everything, so
# yeah, let's do that.

if [ "$(uname)" == "Darwin" ]; then
  echo "› sudo softwareupdate -i -a"
  sudo softwareupdate -i -a

  echo "Installing KBOS"
  rm -rf -f $ZSHDOT/repos/kbos
  git clone git@github.com:alb12-la/KBOS.git $ZSHDOT/repos/kbos
  chmod +x $ZSHDOT/repos/kbos/setup.sh
  cd $ZSHDOT/repos/kbos && ./setup.sh
  cd $ZSHDOT
fi


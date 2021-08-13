#!/usr/bin/env bash
sudo apt install libpq-dev build-essential debhelper git pandoc shunit2 snapd gnome-tweak-tool git tilix \
                 curl vpnc enpass redis-server net-tools imwheel

sudo snap install docker
sudo snap install slack --classic
sudo snap install code --classic
sudo snap install telegram-desktop

if test ! $(which jumpapp)
then
  mkdir ~/tmp
  cd ~/tmp
  git clone https://github.com/mkropat/jumpapp.git
  cd jumpapp
  make deb
  sudo dpkg -i jumpapp*all.deb
  # if there were missing dependencies
  sudo apt-get install -f
fi

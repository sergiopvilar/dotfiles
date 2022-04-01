#!/usr/bin/env bash
sudo apt install libpq-dev build-essential debhelper git pandoc shunit2 snapd gnome-tweak-tool git tilix \
                 curl vpnc redis-server net-tools imwheel zsh unzip

# if test ! $(which exa)
# then
#   wget http://archive.ubuntu.com/ubuntu/pool/universe/r/rust-exa/exa_0.9.0-4_amd64.deb
#   sudo apt-get install ./exa_0.9.0-4_amd64.deb
#   rm exa_0.9.0-4_amd64.deb
# fi

# if test ! $(which delta)
# then
#   wget https://github.com/dandavison/delta/releases/download/0.8.3/git-delta_0.8.3_amd64.deb
#   sudo apt-get install ./git-delta_0.8.3_amd64.deb
#   rm git-delta_0.8.3_amd64.deb
# fi

# if test ! $(which btm)
# then
#   curl -LO https://github.com/ClementTsang/bottom/releases/download/0.6.3/bottom_0.6.3_amd64.deb
#   sudo apt-get install ./bottom_0.6.3_amd64.deb
#   rm bottom_0.6.3_amd64.deb
# fi

exit 0

# wget -P ~/tmp https://github.com/dracula/tilix/archive/master.zip
# unzip ~/tmp/master.zip -d /home/sergio/tmp
# mkdir ~/.config/tilix
# mkdir ~/.config/tilix/schemes
# cp /home/sergio/tmp/tilix-master/Dracula.json ~/.config/tilix/schemes

echo "Installing fonts..."

if [ "$(uname)" != "Darwin" ]; then
  mkdir ~/tmp
  if [ ! -f /home/sergio/tmp/ttf-iosevka-9.0.1.zip ]; then
    wget -P /home/sergio/tmp https://github.com/be5invis/Iosevka/releases/download/v9.0.1/ttf-iosevka-9.0.1.zip
    sudo unzip ~/tmp/ttf-iosevka-9.0.1.zip  -d /usr/share/fonts
  fi

  if [ ! -f /home/sergio/tmp/Hack-v3.003-ttf.zip ]; then
    wget -P /home/sergio/tmp https://github.com/source-foundry/Hack/releases/download/v3.003/Hack-v3.003-ttf.zip
    mkdir ~/tmp/hack
    sudo unzip ~/tmp/Hack-v3.003-ttf.zip -d /home/sergio/tmp/hack
    sudo cp /home/sergio/tmp/hack/ttf/* /usr/share/fonts
  fi

  sudo fc-cache
fi

exit 0

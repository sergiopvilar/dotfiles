if test "$(uname)" = "Linux"
then
  curl -o ~/.dotfiles/bin/wsl-open https://raw.githubusercontent.com/4U6U57/wsl-open/master/wsl-open.sh
  chmod +x ~/.dotfiles/bin/wsl-open
fi

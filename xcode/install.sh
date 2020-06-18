if test "$(uname)" = "Darwin"
  then
  if test ! $(xcode-select -p 1>/dev/null;echo $?)
  then
    # xcode tools
    xcode-select --install
  fi
fi

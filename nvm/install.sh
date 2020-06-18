if [ -d "$NVM_DIR" ]; then
  echo "nvm already installed"
else
  curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.34.0/install.sh | bash
  nvm install node
fi

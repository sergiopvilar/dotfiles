#!/usr/bin/env bash

echo "Installing Dev dependencies..."

if [ "$(uname)" == "Linux" ]; then
  sudo apt-get install ghostscript imagemagick memcached phantomjs wkhtmltopdf build-essential libxslt-dev libxml2-dev postgresql-10 libpq-dev redis-server -y
  # sudo /etc/init.d/postgresql restart
  # sudo -u postgres createuser -s $(whoami); createdb $(whoami); exit 0
fi

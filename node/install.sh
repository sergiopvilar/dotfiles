# Correcting npm permissions
sudo chown -R $(whoami) /usr/local/

if test ! $(which gulp)
then
  npm install gulp -g
fi

if test ! $(which grunt)
then
  npm install grunt -g
fi

if test ! $(which bower)
then
  npm install bower -g
fi

if test ! $(which yo)
then
  npm install yo -g
fi

if test ! $(which node-gyp)
then
  npm install node-gyp -g
fi

if test ! $(which npm-check-updates)
then
  npm install npm-check-updates -g
fi

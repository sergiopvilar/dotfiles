alias nitro_indexes="bin/rails nitro_search:elastic:create_indices"
alias training_qa='qa_training'
alias nitro_help='project_help'

qa_training() {

echo "1. Faz remote shell pra QA normalmente:

    make remoteShell cluster=app-beta-hq env=qa

2. Seta o environment pra training_qa antes de rodar qualquer coisa:

    RAILS_ENV=training_qa bin/rails c\n"
}

shell_qa() {
  make remoteShell env=qa cluster=app-beta-hq
}

nitro_remote_mysql() {
  echo "Connect to mysql://nitro_demo:improvement@127.0.0.1:13306/nitro_demo"
  make reviewDbTunnel pr=$1
}

rubocop_fix() {
  cd ~/pwr/nitro-web
  git status --porcelain | sed s/^...// | grep .rb | xargs -L1 bin/rubocop -A
}

yarn_fix() {
  cd ~/pwr/nitro-web
  git status --porcelain | sed s/^...// | grep .js | xargs -L1 yarn lint --fix
  git status --porcelain | sed s/^...// | grep .jsx | xargs -L1 yarn lint --fix
}

spec() {
  clear
  file=$1
  component=${PWD##*/}
  toRemove="components/$component/"
  toReplace=""
  filePath="${file/"$toRemove"/"$toReplace"}"
  bin/rspec $filePath
}

resque() {
  cd ~/pwr/nitro-web
  bin/rake resque:work QUEUE="*"
}

rollback() {
  cd ~/pwr/nitro-web
  bin/rails db:rollback
  cd components/$1
  bin/rails db:rollback
  bin/schema
}

nitro_refresh() {
  cd ~/pwr/nitro-web
  git checkout master
  git pull
  bundle
  docker-compose down --volumes
  make start
  bin/rails dev:load_recent
  nitro_indexes
}

bundle_component() {
  bundle config --local path ../../vendor/bundle
  bundle install
}

bundle_dependents() {
  dir=${PWD##*/}
  cd ../../
  bin/cobra exec $dir bundle --dependents
  cd components/$dir
}

rspec_component() {
  bundle_component
  bin/schema
  bin/rspec
}

run() {
  cd ~/pwr/nitro-web
  make stop
  make start
  WEB_CONCURRENCY=1 RAILS_MAX_THREADS=1 WEB_WORKER_TIMEOUT=6000000 bin/rails s
}

yarn_component() {
  dir=${PWD##*/}
  cd ../../
  PACKS=$dir yarn hmr
}

yarn_refresh() {
  rm -rf node_modules && yarn cache clean && yarn
  terminal-notifier -message 'Finished Refresh' -title 'Yarn' -sound default
}

run() {
  cd ~/pwr/nitro-web
  open -a Docker
  make start
  bin/rails s
}

ncommit() {
  git diff
  if read -q "choice?Deseja fazer o commit? [Y/N]:"; then
      STR=$(pwd)
      SUB='components'
      if grep -q "$SUB" <<< "$STR"; then
        echo "\nRunning yarn lint --fix..."
        yarn lint --fix
      fi
      echo "Running rubocop fix..."
      rubocop_fix
      echo "Adding changes..."
      git add -A
      echo "Running git commit..."
      git commit
  else
      echo
      echo "Blz..."
  fi
}

project_help() {
  echo "nitro_indexes                     Indexes everything nitro needs into elasticsearch
training_qa                       Instructions on how to connect to training_qa
shell_qa                          Opens up a shell in QA
nitro_remote_mysql <pr_number>    Creates a MySQL tunnel for the given PR
nitro_refresh                     Drop the containers and load a new database
bundle_component                  Sets bundler configuration for component and runs bundle install
rspec_component                   Does the configuration and runs bin/rspec for the component
yarn_component                    Runs yarn hmr for the current component
run                               Create the containers and runs rails"
}


function dbreset {
  local environment=$1;
  local oldEnv=$RAILS_ENV

  if [ -z "$environment" ]; then
    environment=$oldEnv;
    if [ -z "$environment" ]; then
      environment="development";
    fi
  fi

  export RAILS_ENV=$environment;
  bundle exec rake db:drop && bundle exec rake db:create && bundle exec rake db:migrate && bundle exec rake db:seed;
  RAILS_ENV=$oldEnv
}

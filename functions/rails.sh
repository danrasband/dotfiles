function dbreset {
  local environment=$1;
  local oldEnv=$RAILS_ENV

  if [ -z "$environment" ]; then
    environment="development";
  fi

  export RAILS_ENV=$environment;
  bin/rake db:drop && bin/rake db:create && bin/rake db:migrate && bin/rake db:seed;
  RAILS_ENV=$oldEnv
}

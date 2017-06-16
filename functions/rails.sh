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
  echo "bundle exec rake db:drop" && \
  bundle exec rake db:drop && \
  echo "bundle exec rake db:create" && \
  bundle exec rake db:create && \
  echo "bundle exec rake db:migrate" && \
  bundle exec rake db:migrate;
  if [ $? -eq 0 ]; then
    if [ "$environment" != "test" ]; then
      bundle exec rake db:seed;
    fi
  fi
  export RAILS_ENV=$oldEnv
}

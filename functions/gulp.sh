function gall {
  local environment=$1;
  local oldEnv=$RAILS_ENV

  if [ -z "$environment" ]; then
    environment=$oldEnv;
  fi
  if [ -z "$environment" ]; then
    environment="development";
  fi

  echo "gulp clean" && \
  gulp clean && \
  echo "gulp build-$environment" && \
  gulp build-$environment && \
  echo "gulp serve-$environment" && \
  gulp serve-$environment;
}

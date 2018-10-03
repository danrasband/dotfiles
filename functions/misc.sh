function countdown {
  local seconds=$1;

  if [ -z "$seconds" ]; then
    echo 'Must provide the number of seconds to count down from.';
  fi

  while [ $seconds -gt 0 ]; do
    echo "$seconds..."
    sleep 1;
    seconds=$((seconds-1));
  done

  echo 'Boom!';
  say "Boom\!";
  return;
}    

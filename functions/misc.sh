function countdown {
  local seconds=$1;

  if [ -z "$seconds" ]; then
    echo 'Must provide the number of seconds to count down from.';
  fi

  while [ $seconds -gt 0 ]; do
    sleep 1;
    echo -n '.'
    seconds=$((seconds-1));
  done

  say 'Done'
  return;
}    

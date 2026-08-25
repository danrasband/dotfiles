# Utility Functions

function countdown {
  local total_seconds=$1
  
  if [ -z "$total_seconds" ]; then
    echo "Usage: countdown <seconds>"
    return 1
  fi
  
  echo "Starting countdown from $total_seconds seconds..."
  local total_seconds=$1
  
  while [ $total_seconds -gt 0 ]; do
    printf "\r%02d seconds remaining" $total_seconds
    sleep 1
    total_seconds=$((total_seconds - 1))
  done
  
  echo
  echo "Countdown complete!"
}

# Put all non-directory files into folders based on their extensions.
function cleanup-files-by-ext {
  for filename in *; do
    if [[ -f "$filename" ]]; then
      base=${filename%.*}
      ext=${filename#$base.}

      if [ -z "${ext}" ]; then
        ext="no-extension";
      fi

      mkdir -p "${ext}"
      mv "$filename" "${ext}/"
    fi
  done
}

function journalinit() {
  local directory=$HOME/.journal
  echo -n "What is your gpg key's email address? "
  read email
  
  echo $email > $directory/.config

  echo "Your journal will be encrypted for $email."
}

function journalnew() {
  local directory=$HOME/.journal
  local name=$1
  local filepath=$directory/$name
  local config=$directory/.config

  if [ ! -f "$config" ]; then
    echo "Please run journalinit to configure your journal."
    return
  fi

  email=$(cat $config | tr -d '\n')
  if [ -z "$email" ]; then
    echo "Please run journalinit to reconfigure your journal. The email recipient is empty."
    return
  fi

  if [ -z "$name" ]; then
    echo "Please specify a file name."
    return
  fi

  if [ ! -d "$directory" ]; then
    mkdir $directory
  fi

  if [ -f "$filepath.gpg" ]; then
    echo "File already exists. Use journalopen to access it."
    return
  fi

  rvim $filepath;

  if [ -f "$filepath" ]; then
    gpg --encrypt --recipient $email $filepath;
    rm $filepath
    return
  fi

  echo 'Finished without creating journal file.'
}

function journalopen() {
  local directory=$HOME/.journal
  local name=$1
  local filepath=$directory/$name

  if [ ! -f "$filepath.gpg" ]; then
    echo 'Journal entry "'$name'" does not exist.'
    return
  fi

  echo "decrypting $filepath.gpg"
  gpg --output $filepath --decrypt $filepath.gpg
  rvim $filepath

  gpg -c $filepath
  rm $filepath
}

function journalrm() {
  local directory=$HOME/.journal
  local name=$1
  local filepath=$directory/$name

  if [ -z "$name" ]; then
    echo 'Specify a journal name'
    return
  fi

  rm $filepath $filepath.gpg
}

function journalls() {
  local directory=$HOME/.journal

  local entries=$(ls $directory)

  for entry in ${entries[@]}; do
    name=${entry:0:$((${#entry}-4))};
    echo $name
  done
}

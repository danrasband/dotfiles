importdb() {
  local $dbname=$1
  local $file=$2

  mysql -u root <<< "DROP DATABASE $dbname; CREATE DATABASE $dbname;"
  mysql -u root $dbname < $file
}

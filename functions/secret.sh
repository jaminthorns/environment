secrets_path=$1

function secret {
  if test ! -e $secrets_path; then
    touch $secrets_path
  fi

  local name=$1
  local value=$(grep "$1" $secrets_path | cut -d "=" -f 2)

  if test -z "$value"; then
    read -r -p "$name: " value < /dev/tty
    echo "$name=$value" >> $secrets_path
  fi

  echo $value
}

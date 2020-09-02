secrets=$1

function secret {
  if [ ! -e $secrets ]; then
    touch $secrets
  fi

  local name=$1
  local value=$(grep "$1" $secrets | cut -d "=" -f 2)

  if [ -z "$value" ]; then
    read -p "$name: " value < /dev/tty
    echo "$name=$value" >> $secrets
  fi

  echo $value
}

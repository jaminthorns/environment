function key {
  if [ $(get_os) = "mac_os" ]; then
    echo $1
  else
    echo $2
  fi
}

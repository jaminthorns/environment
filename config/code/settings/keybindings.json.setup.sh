function modifier {
  if [ $(get_os) = "mac_os" ]; then
    echo "cmd"
  else
    echo $1
  fi
}

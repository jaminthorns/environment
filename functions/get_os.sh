function get_os {
  if [ $(uname -s) = "Darwin" ]; then
    echo "mac_os"
  elif [ $(uname -s) = "Linux" ] && uname -r | grep -q "microsoft"; then
    echo "wsl"
  fi
}

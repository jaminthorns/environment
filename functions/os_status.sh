function os_status {
  case $1 in
    mac-os)
      test $(uname -s) = "Darwin";;
    linux)
      test $(uname -s) = "Linux";;
    wsl)
      test $(uname -s) = "Linux" && uname -r | grep -q "microsoft";;
  esac
}

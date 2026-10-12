function os_status {
  case $1 in
    mac-os)
      test $(uname -s) = "Darwin";;
    linux)
      test $(uname -s) = "Linux";;
    wsl)
      os_status linux && uname -r | grep -q "microsoft";;
    linux-non-wsl)
      os_status linux && ! os_status wsl;;
    fedora)
      os_status linux && cat /etc/os-release | grep -q ID=fedora;;
    ubuntu)
      os_status linux && cat /etc/os-release | grep -q ID=ubuntu;;
  esac
}

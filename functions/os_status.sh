function os_status {
  case $1 in
    mac-os)
      test $(uname -s) = "Darwin";;
    linux)
      test $(uname -s) = "Linux";;
    linux-wsl)
      os_status linux && uname -r | grep -q "microsoft";;
    linux-desktop)
      os_status linux && ! os_status linux-wsl;;
    linux-fedora)
      os_status linux && cat /etc/os-release | grep -q ID=fedora;;
    linux-ubuntu)
      os_status linux && cat /etc/os-release | grep -q ID=ubuntu;;
  esac
}

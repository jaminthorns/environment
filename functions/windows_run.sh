function windows_run {
  if os_status wsl; then
    cmd.exe /c $@ 2> /dev/null
  else
    $@
  fi
}

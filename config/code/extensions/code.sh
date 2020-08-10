function code {
  if [ $(get_os) = "wsl" ]; then
    cmd.exe /c "code $@" 2> /dev/null
  else
    code $@
  fi
}

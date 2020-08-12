function run_code {
  if os_status wsl; then
    cmd.exe /c "code $@" 2> /dev/null
  else
    code $@
  fi
}

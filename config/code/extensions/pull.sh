if os_status linux-wsl; then
  windows_run code --list-extensions > extensions
else
  code --list-extensions > extensions
fi

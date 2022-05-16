if os_status wsl; then
  windows_run code --list-extensions > extensions
else
  code --list-extensions > extensions
fi

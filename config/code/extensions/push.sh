config_extensions=$(cat extensions | sort)

function push_extensions {
  local code_command=$1
  local installed_extensions=$(echo "$2" | sort)

  for extension in $(comm -23 <(echo "$config_extensions") <(echo "$installed_extensions")); do
    $code_command --install-extension $extension
  done

  for extension in $(comm -13 <(echo "$config_extensions") <(echo "$installed_extensions")); do
    $code_command --uninstall-extension $extension
  done
}

if os_status wsl; then
  push_extensions "windows_run code" "$(windows_run code --list-extensions)"
  push_extensions "code" "$(code --list-extensions | grep -v 'Extensions installed on')"
else
  push_extensions "code" "$(code --list-extensions)"
fi

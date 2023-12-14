local config_extensions=$(cat extensions | sort)

function push_extensions {
  local code_command=$1
  local installed_extensions=$(echo "$2" | sort)

  comm -23 <(echo "$config_extensions") <(echo "$installed_extensions") | xargs -r -n 1 $code_command --install-extension $extension
  comm -13 <(echo "$config_extensions") <(echo "$installed_extensions") | xargs -r -n 1 $code_command --uninstall-extension $extension
}

if os_status wsl; then
  push_extensions "windows_run code" "$(windows_run code --list-extensions)"
  push_extensions "code" "$(code --list-extensions | grep -v 'Extensions installed on')"
else
  push_extensions "code" "$(code --list-extensions)"
fi

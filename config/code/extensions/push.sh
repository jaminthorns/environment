config_extensions=$(cat extensions | sort)
installed_extensions=$(windows_run code --list-extensions | sort)

for extension in $(comm -23 <(echo "$config_extensions") <(echo "$installed_extensions")); do
  windows_run code --install-extension $extension
done

for extension in $(comm -13 <(echo "$config_extensions") <(echo "$installed_extensions")); do
  windows_run code --uninstall-extension $extension
done

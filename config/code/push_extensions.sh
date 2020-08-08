config_extensions=$(cat extensions)
installed_extensions=$(code --list-extensions)

for extension in $(comm -23 <(echo "$config_extensions") <(echo "$installed_extensions")); do
  code --install-extension $extension
done

for extension in $(comm -13 <(echo "$config_extensions") <(echo "$installed_extensions")); do
  code --uninstall-extension $extension
done

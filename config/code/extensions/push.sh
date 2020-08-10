source run_code.sh

config_extensions=$(cat extensions)
installed_extensions=$(run_code --list-extensions)

for extension in $(comm -23 <(echo "$config_extensions") <(echo "$installed_extensions")); do
  run_code --install-extension $extension
done

for extension in $(comm -13 <(echo "$config_extensions") <(echo "$installed_extensions")); do
  run_code --uninstall-extension $extension
done

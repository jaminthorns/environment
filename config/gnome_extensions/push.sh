config_extensions=$(cat extensions | sort)
installed_extensions=$(gnome-extensions list --user | sort)

for extension in $(comm -23 <(echo "$config_extensions") <(echo "$installed_extensions")); do
  gnome-browser-connector gnome-extensions://$(echo $extension | sed -e 's/@/%40/g')?action=install
done

for extension in $(comm -13 <(echo "$config_extensions") <(echo "$installed_extensions")); do
  gnome-extensions uninstall $extension
done

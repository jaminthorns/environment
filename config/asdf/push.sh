config_plugins=$(cut -d " " -f 1 config/.tool-versions)
installed_plugins=$(asdf plugin list)

for plugin in $(comm -23 <(echo "$config_plugins") <(echo "$installed_plugins")); do
  asdf plugin add $plugin
done

for plugin in $(comm -13 <(echo "$config_plugins") <(echo "$installed_plugins")); do
  asdf plugin remove $plugin
done

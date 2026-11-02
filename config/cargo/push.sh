config_packages=$(read_config packages | grep -v "^$" | sort)
installed_packages=$(cargo install --list | grep "    " | tr -d " " | sort)

for extension in $(comm -23 <(echo "$config_packages") <(echo "$installed_packages")); do
  cargo install $extension
done

for extension in $(comm -13 <(echo "$config_packages") <(echo "$installed_packages")); do
  cargo uninstall $extension
done

asdf reshim rust

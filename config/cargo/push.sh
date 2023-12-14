local config_packages=$(cat packages | sort)
local installed_packages=$(cargo install --list | grep "    " | tr -d " " | sort)

comm -23 <(echo "$config_packages") <(echo "$installed_packages") | xargs -r cargo install
comm -13 <(echo "$config_packages") <(echo "$installed_packages") | xargs -r cargo uninstall

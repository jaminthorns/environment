current_packages=$(mktemp)
evaluated_packages=$(mktemp)

cargo install --list | grep "    " | tr -d " " > $current_packages
read_config packages | grep -v "^$" > $evaluated_packages

merge_config packages $current_packages $evaluated_packages
rm $current_packages $evaluated_packages

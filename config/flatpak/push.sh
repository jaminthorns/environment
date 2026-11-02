config_applications=$(cat applications | sort)
installed_applications=$(flatpak list --app --columns=application | tail -n +2 | sort)

for application in $(comm -23 <(echo "$config_applications") <(echo "$installed_applications")); do
  flatpak install -y flathub $application
done

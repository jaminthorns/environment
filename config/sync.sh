source ../functions/mac_os_key.sh
source ../functions/os_status.sh
source ../functions/windows_run.sh
source ../functions/secret.sh ../secrets/values

copy asdf/tools $HOME
copy brew $HOME
copy fish $HOME/.config/fish
copy git $HOME
copy mycli $HOME
copy pgcli $HOME/.config/pgcli
copy yarn $HOME/.config/yarn/global

if os_status mac-os; then
  copy code/settings "$HOME/Library/Application Support/Code/User"
  copy hammerspoon $HOME/.hammerspoon
fi

if os_status linux-non-wsl; then
  copy code/settings $HOME/.config/Code/User
fi

if os_status mac-os || os_status linux-non-wsl; then
  copy kitty $HOME/.config/kitty
fi

if os_status wsl; then
  copy autohotkey "$APPDATA/Microsoft/Windows/Start Menu/Programs/Startup"
  copy code/settings "$APPDATA/Code/User"
  copy windows_terminal "$LOCALAPPDATA/Packages/Microsoft.WindowsTerminal_8wekyb3d8bbwe/LocalState"
fi

run code/extensions/push.sh code/extensions/pull.sh

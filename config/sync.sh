source ../functions/os_status.sh
source ../functions/secret.sh ../secrets/values

copy asdf/tools $HOME
copy brew $HOME
copy fish $HOME/.config/fish
copy git $HOME
copy yarn $HOME/.config/yarn/global

if os_status mac-os; then
  copy code/settings "$HOME/Library/Application Support/Code/User"
  copy hammerspoon $HOME/.hammerspoon
  copy iterm $HOME/.iterm
fi

if os_status linux && ! os_status wsl; then
  copy code/settings $HOME/.config/Code/User
fi

if os_status wsl; then
  copy autohotkey "$APPDATA/Microsoft/Windows/Start Menu/Programs/Startup"
  copy code/settings "$APPDATA/Code/User"
  copy windows_terminal "$LOCALAPPDATA/Packages/Microsoft.WindowsTerminal_8wekyb3d8bbwe/LocalState"
fi

run code/extensions/push.sh code/extensions/pull.sh

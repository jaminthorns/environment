source ../functions/get_os.sh
source ../secrets/values.sh

copy asdf $HOME
copy brew $HOME
copy fish $HOME/.config/fish
copy git $HOME
copy yarn $HOME/.config/yarn/global

if [ $(get_os) = "mac_os" ]; then
  copy code/settings "$HOME/Library/Application Support/Code/User"
  copy hammerspoon $HOME/.hammerspoon
fi

if [ $(get_os) = "wsl" ]; then
  copy autohotkey "$APPDATA/Microsoft/Windows/Start Menu/Programs/Startup"
  copy code/settings "$APPDATA/Code/User"
  copy windows_terminal "$LOCALAPPDATA/Packages/Microsoft.WindowsTerminal_8wekyb3d8bbwe/LocalState"
fi

run code/extensions/push.sh code/extensions/pull.sh

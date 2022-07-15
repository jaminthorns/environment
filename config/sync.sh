source ../functions/config_functions.sh ..

copy asdf/tools $HOME
copy elixir $HOME
copy fish/config $HOME/.config/fish
copy git/config $HOME
copy github_cli $HOME/.config/gh
copy homebrew $HOME
copy mycli $HOME
copy pgcli $HOME/.config/pgcli

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
  copy windows_terminal "$LOCALAPPDATA/Packages/Microsoft.WindowsTerminalPreview_8wekyb3d8bbwe/LocalState"
fi

on_push code/extensions/push.sh
on_pull code/extensions/pull.sh

on_push fish/configure_tide.sh

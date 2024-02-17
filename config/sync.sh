source ../functions/config_functions.sh

copy asdf $HOME
copy elixir $HOME
copy fish/config $HOME/.config/fish
copy git/config $HOME
copy github_cli $HOME/.config/gh
copy homebrew $HOME
copy lf/config $HOME/.config/lf
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
  copy continue $HOME/.continue
  copy wezterm $HOME/.config/wezterm
fi

if os_status wsl; then
  copy autohotkey "$APPDATA/Microsoft/Windows/Start Menu/Programs/Startup"
  copy code/settings "$APPDATA/Code/User"
  copy continue "$USERPROFILE/.continue"
  copy wezterm "$ProgramFiles/WezTerm"
fi

on_push cargo/push.sh
on_pull cargo/pull.sh

on_push code/extensions/push.sh
on_pull code/extensions/pull.sh

on_push fish/configure_tide.sh

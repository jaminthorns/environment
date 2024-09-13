source ../functions/config_functions.sh

copy asdf/config "$HOME"
copy elixir "$HOME"
copy fish/config "$HOME/.config/fish"
copy git/config "$HOME/.config/git"
copy github_cli "$HOME/.config/gh"
copy homebrew "$HOME"
copy lf/config "$HOME/.config/lf"
copy litecli "$HOME/.config/litecli"
copy mycli "$HOME"
copy obsidian "$(secret OBSIDIAN_VAULT_PATH)/.obsidian"
copy pgcli "$HOME/.config/pgcli"

if os_status mac-os; then
  copy code/settings "$HOME/Library/Application Support/Code/User"
  copy hammerspoon "$HOME/.hammerspoon"
fi

if os_status linux-non-wsl; then
  copy code/settings "$HOME/.config/Code/User"
fi

if os_status mac-os || os_status linux-non-wsl; then
  copy wezterm "$HOME/.config/wezterm"
fi

if os_status wsl; then
  copy autohotkey "$APPDATA/Microsoft/Windows/Start Menu/Programs/Startup"
  copy code/settings "$APPDATA/Code/User"
  copy wezterm "$ProgramFiles/WezTerm"
fi

on_push asdf/push.sh
on_pull asdf/pull.sh

on_push cargo/push.sh
on_pull cargo/pull.sh

on_push code/state/push.sh
on_push code/extensions/push.sh
on_pull code/extensions/pull.sh

on_push fish/configure_tide.sh

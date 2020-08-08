source ../secrets/values.sh

copy asdf $HOME
copy brew $HOME
copy code/settings "$HOME/Library/Application Support/Code/User"
copy fish $HOME/.config/fish
copy git $HOME
copy hammerspoon $HOME/.hammerspoon
copy yarn $HOME/.config/yarn/global

run code/pull_extensions.sh code/push_extensions.sh

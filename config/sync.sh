source ../secrets/values.sh

copy asdf $HOME
copy brew $HOME
copy fish $HOME/.config/fish
copy git $HOME
copy yarn $HOME/.config/yarn/global

if [ $(uname) = "Darwin" ]; then
  copy hammerspoon $HOME/.hammerspoon
  copy code/settings "$HOME/Library/Application Support/Code/User"
fi

run code/push_extensions.sh code/pull_extensions.sh

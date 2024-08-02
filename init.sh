#!/usr/bin/env bash

source functions/read_config.sh
source functions/config_functions.sh

# Install Linux dependencies
os_status linux && sudo apt update && sudo apt upgrade -y && find config/linux_dependencies -type f | xargs cat | xargs sudo apt install -y

# Get Homebrew path
os_status linux && brew="/home/linuxbrew/.linuxbrew/bin/brew" || brew="/opt/homebrew/bin/brew"

# Install Homebrew if not already installed
test -x $brew || bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"

# Initialize Homebrew
eval $($brew shellenv)

# Install Homebrew packages
read_config config/homebrew/.Brewfile | brew bundle --no-lock --file=-

# Initialize asdf
source $(brew --prefix asdf)/libexec/asdf.sh

# Add asdf plugins
cut -d " " -f 1 config/asdf/config/.tool-versions | xargs -n 1 asdf plugin add

# Install asdf programs
(cd config/asdf/config && asdf install)

# Install Fisher and plugins
fish -c "curl -sL https://raw.githubusercontent.com/jorgebucaran/fisher/main/functions/fisher.fish | source && set fisher_path \$__fish_config_dir/fisher && cat config/fish/config/fish_plugins | fisher install"

# Get fish path
fish=$(command -v fish)

# Add fish to shells if not already present
grep -q $fish /etc/shells || echo $fish | sudo tee -a /etc/shells

# Change shell to fish if not already changed
test $SHELL = $fish || chsh -s $fish

# Push configuration
source push.sh

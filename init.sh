#!/bin/bash

source functions/create_secrets.sh
source functions/get_os.sh

# Create secrets if not already created
test -e secrets/values.sh || create_secrets secrets/variables secrets/values.sh

# Get Homebrew path
test $(get_os) = "mac_os" && brew="/usr/local/bin/brew" || brew="/home/linuxbrew/.linuxbrew/bin/brew"

# Install Homebrew
test -x $brew || bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"

# Initialize Homebrew
eval $($brew shellenv)

# Install Homebrew packages
brew bundle --no-lock --file=config/brew/.Brewfile

# Initialize asdf
source $(brew --prefix asdf)/asdf.sh

# Add asdf plugins
cat config/asdf/.tool-versions | cut -d " " -f 1 | xargs -n 1 asdf plugin-add

# Install asdf programs
(cd config/asdf && NODEJS_CHECK_SIGNATURES=no asdf install)

# Install Fisher
curl https://git.io/fisher --create-dirs -sLo $HOME/.config/fish/functions/fisher.fish

# Push config files to home directory
source push.sh

# Install global Yarn packages
yarn global add

# Install Fisher packages
fish -c fisher

# Get fish path
fish=$(command -v fish)

# Add fish to shells if not already present
grep -q $fish /etc/shells || echo $fish | sudo tee -a /etc/shells

# Change shell to fish if not already changed
test $SHELL = $fish || chsh -s $fish

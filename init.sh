#!/bin/bash

source functions/create_secrets.sh

# Create secrets if not already created
test -e secrets/values.sh || create_secrets secrets/variables secrets/values.sh

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

# Add fish to shells if not already present
grep -q $(which fish) /etc/shells || echo $(which fish) | sudo tee -a /etc/shells

# Change shell to fish if not already changed
test $SHELL = $(which fish) || chsh -s $(which fish)

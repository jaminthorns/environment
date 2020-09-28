#!/bin/bash

source functions/os_status.sh

# Install dependencies for compiled asdf programs
os_status linux && sudo apt update && find config/asdf/dependencies -type f | xargs cat | xargs sudo apt install -y

# Get Homebrew path
os_status linux && brew="/home/linuxbrew/.linuxbrew/bin/brew" || brew="/usr/local/bin/brew"

# Install Homebrew if not already installed
test -x $brew || bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"

# Initialize Homebrew
eval $($brew shellenv)

# Install Homebrew packages
brew bundle --no-lock --file=config/brew/.Brewfile

# Initialize asdf
source $(brew --prefix asdf)/asdf.sh

# Add asdf plugins
cat config/asdf/tools/.tool-versions | cut -d " " -f 1 | xargs -n 1 asdf plugin add

# Install asdf programs
(cd config/asdf/tools && NODEJS_CHECK_SIGNATURES=no asdf install)

# Install Fisher
curl https://git.io/fisher --create-dirs -sLo $HOME/.config/fish/functions/fisher.fish

# Push configuration
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

#!/bin/bash

source functions/get_os.sh

# Upgrade Linux packages
test $(get_os) = "wsl" && sudo apt update && sudo apt upgrade -y

# Upgrade Homebrew packages
brew upgrade

# Update asdf plugins
asdf plugin update --all

# Update Fisher
fish -c fisher self-update

# Update Fisher packages
fish -c fisher

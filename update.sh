#!/bin/bash

source functions/os_status.sh

# Upgrade Linux packages
os_status linux && sudo apt update && sudo apt upgrade -y

# Upgrade Homebrew packages
brew upgrade

# Update asdf plugins
asdf plugin update --all

# Update Fisher
fish -c fisher self-update

# Update Fisher packages
fish -c fisher

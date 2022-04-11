#!/usr/bin/env bash

source functions/os_status.sh

# Upgrade Linux packages
os_status linux && sudo apt update && sudo apt upgrade -y

# Upgrade Homebrew packages
brew upgrade

# Update asdf plugins
asdf plugin update --all

# Update Fisher packages
fish -c "fisher update"

#!/usr/bin/env bash

source functions/os_status.sh

# Upgrade Linux packages
os_status linux && sudo dnf upgrade

# Upgrade Homebrew packages
brew upgrade

# Update asdf plugins
asdf plugin update --all

# Update Fisher plugins
fish -c "fisher update"

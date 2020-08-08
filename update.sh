#!/bin/bash

# Upgrade Homebrew packages
brew upgrade

# Update asdf plugins
asdf plugin update --all

# Update Fisher
fish -c fisher self-update

# Update Fisher packages
fish -c fisher

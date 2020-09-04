tap "homebrew/cask"
tap "homebrew/cask-fonts"

# General
brew "asdf"
brew "awscli"
brew "bat"
brew "fish"
brew "fzf"
brew "git-delta"
brew "git"
brew "ripgrep"
brew "yarn"

if OS.mac?
  # Dependencies for compiled asdf programs
  brew "erlang", args: ["only-dependencies"]
  brew "postgresql", args: ["only-dependencies"]

  # Casks
  cask "font-jetbrains-mono"
  cask "hammerspoon"
  cask "kitty"
end

brew "asdf"
brew "awscli"
brew "bat"
brew "fish"
brew "fzf"
brew "git-delta"
brew "git"
brew "gpg"
brew "mycli"
brew "pandoc"
brew "pgcli"
brew "ripgrep"
brew "yarn"

if OS.mac?
  tap "homebrew/cask"
  tap "homebrew/cask-fonts"

  cask "font-jetbrains-mono"
  cask "hammerspoon"
  cask "kitty"
  cask "ngrok"

  # Dependencies for compiled asdf programs
  brew "erlang", args: ["only-dependencies"]
  brew "postgresql", args: ["only-dependencies"]
end

brew "asdf"
brew "bat"
brew "bottom"
brew "broot"
brew "exa"
brew "fd"
brew "fish"
brew "fzf"
brew "gh"
brew "git-delta"
brew "git-interactive-rebase-tool"
brew "git"
brew "gpg"
brew "imagemagick"
brew "less"
brew "mycli"
brew "pandoc"
brew "pgcli"
brew "ripgrep"

# Dependencies for compiled asdf programs
brew "erlang", args: ["only-dependencies"]
brew "postgresql@14", args: ["only-dependencies"]

if OS.mac?
  tap "homebrew/cask"
  tap "homebrew/cask-fonts"

  cask "font-jetbrains-mono"
  cask "hammerspoon"
  cask "kitty"
  cask "ngrok"
end

{{read_local Brewfile}}

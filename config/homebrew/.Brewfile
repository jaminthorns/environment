brew "as-tree"
brew "asdf"
brew "bat"
brew "bottom"
brew "chafa"
brew "diffutils"
brew "dua-cli"
brew "exa"
brew "exiftool"
brew "fd"
brew "ffmpeg"
brew "fish"
brew "fzf"
brew "gh"
brew "git-delta"
brew "git-interactive-rebase-tool"
brew "git"
brew "gpg"
brew "gum"
brew "imagemagick"
brew "less"
brew "lf"
brew "mycli"
brew "pandoc"
brew "pgcli"
brew "poppler"
brew "ripgrep"
brew "vivid"

if OS.mac?
  cask "hammerspoon"
  cask "ngrok"
  cask "wezterm"
  cask "homebrew/cask-fonts/font-jetbrains-mono"

  # Dependencies for compiled asdf programs
  brew "erlang", args: ["only-dependencies"]
  brew "postgresql@14", args: ["only-dependencies"]
end

{{read_local Brewfile}}

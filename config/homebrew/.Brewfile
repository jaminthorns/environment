brew "as-tree"
brew "asdf"
brew "bat"
brew "bottom"
brew "chafa"
brew "diffutils"
brew "dua-cli"
brew "exiftool"
brew "eza"
brew "fd"
brew "ffmpeg"
brew "fish"
brew "fzf"
brew "gh"
brew "git-delta"
brew "git-interactive-rebase-tool"
brew "git"
brew "gpg"
brew "imagemagick"
brew "less"
brew "lf"
brew "mycli"
brew "pandoc"
brew "pgcli"
brew "poppler"
brew "ripgrep"
brew "tldr"
brew "vivid"

# Dependencies for ripdrag
brew "gtk4"
brew "pkg-config"

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

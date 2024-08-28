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
brew "jq"
brew "less"
brew "lf"
brew "mycli"
brew "ollama"
brew "ouch"
brew "pandoc"
brew "pastel"
brew "pgcli"
brew "poppler"
brew "ripgrep"
brew "tldr"

if OS.mac?
  cask "font-jetbrains-mono"
  cask "hammerspoon"
  cask "ngrok"
  cask "wezterm"

  # Dependencies for compiled asdf programs
  brew "erlang", args: ["only-dependencies"]
  brew "postgresql@14", args: ["only-dependencies"]
end

{{read_local Brewfile}}

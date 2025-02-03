brew "asdf"
brew "bat"
brew "bottom"
brew "chafa"
brew "cloudflared"
brew "diffutils"
brew "docker"
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
brew "litecli"
brew "mycli"
brew "ollama"
brew "ouch"
brew "pandoc"
brew "pastel"
brew "pgcli"
brew "podman"
brew "poppler"
brew "ripgrep"
brew "tldr"

if OS.mac?
  cask "font-jetbrains-mono"
  cask "font-symbols-only-nerd-font"
  cask "hammerspoon"
  cask "wezterm"

  # Dependencies for compiled asdf programs
  brew "erlang@27", args: ["only-dependencies"]
  brew "postgresql@17", args: ["only-dependencies"]
end

{{read_local Brewfile}}

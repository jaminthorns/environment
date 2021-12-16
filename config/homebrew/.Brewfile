brew "asdf"
brew "bat"
brew "exa"
brew "fd"
brew "fish"
brew "fzf"
brew "gh"
brew "git-delta"
brew "git"
brew "gpg"
brew "imagemagick"
brew "mycli"
brew "pandoc"
brew "pgcli"
brew "ripgrep"

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

# Local Brewfile
local_brewfile_path = File.expand_path("~/.local_config/Brewfile")

if File.exist?(local_brewfile_path)
  eval(IO.read(local_brewfile_path))
end

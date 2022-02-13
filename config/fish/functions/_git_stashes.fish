function _git_stashes
  set preview_command "echo {} | cut -d ':' -f 1 | xargs -I [] git stash show --patch [] | delta --width \$FZF_PREVIEW_COLUMNS"

  git stash list | fzf --no-sort --preview $preview_command | cut -d ':' -f 1
end

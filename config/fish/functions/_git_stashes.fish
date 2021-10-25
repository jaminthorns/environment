function _git_stashes
  set preview_command "echo {} | cut -d ':' -f 1 | xargs -I _ git stash show --patch _ | delta --width \$FZF_PREVIEW_COLUMNS"

  git stash list | fzf --no-sort --preview $preview_command | cut -d ':' -f 1
end

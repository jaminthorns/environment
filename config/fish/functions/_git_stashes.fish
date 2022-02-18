function _git_stashes
    set commit_command "echo {} | cut -d ':' -f 1"
    set view_command "$commit_command | xargs -I [] git stash show --patch []"
    set preview_command "$view_command | delta --width \$FZF_PREVIEW_COLUMNS"

    git stash list | fzf --no-sort --preview="$preview_command" \
        --bind="alt-enter:execute($view_command)" \
        --bind="enter:execute($commit_command)+abort" \
        --bind="double-click:execute($commit_command)+abort"
end

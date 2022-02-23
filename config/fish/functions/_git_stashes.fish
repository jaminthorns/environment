function _git_stashes
    _git_fzf_command \
        --fzf-flags --multi \
        --list-command "git stash list" \
        --item-command "cut -d ':' -f 1" \
        --view-command "xargs -I [] git stash show --patch []"
end

function _git_stashes --wraps 'git stash'
    _git_fzf_command \
        --flags --multi \
        --list-command "git stash list $argv" \
        --item-command "cut -d ':' -f 1" \
        --view-command "xargs -I [] git stash show --patch []"
end

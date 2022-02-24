function _git_branches
    _git_fzf_command \
        --flags "--ansi --multi" \
        --list-command "git branch --color $argv" \
        --item-command "sed -e 's/*//' -e 's/->//' | string split --no-empty ' '" \
        --view-command "xargs git graph --color"
end

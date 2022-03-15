function _git_history --wraps 'git graph'
    argparse --ignore-unknown "p/path=" -- $argv

    if set -q _flag_path
        set path -- $_flag_path
    end

    _git_fzf_command \
        --flags "--ansi --multi --no-sort" \
        --list-command "git graph --color $argv $path" \
        --item-command "grep -oE '[0-9a-f]+ - ' | cut -d ' ' -f 1" \
        --view-command "xargs -I [] git show --color [] $path"
end

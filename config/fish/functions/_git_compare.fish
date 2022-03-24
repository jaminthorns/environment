function _git_compare --wraps 'git diff'
    argparse --ignore-unknown "p/path=" -- $argv

    if set -q _flag_path
        set path -- $_flag_path
    end

    _git_fzf_command \
        --flags "--ansi --multi" \
        --header (git diff --shortstat $argv $path) \
        --list-command "git diff --stat --name-status $argv $path | _git_name_status_format" \
        --item-command "cut -d ' ' -f 2,4" \
        --view-command "xargs git diff $argv --"
end

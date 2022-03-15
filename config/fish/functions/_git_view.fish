function _git_view --wraps 'git show'
    argparse --ignore-unknown "p/path=" -- $argv

    if set -q _flag_path
        set path -- $_flag_path
    end

    set header (git show --format="" --shortstat $argv $path)
    set summary_command "git show --no-patch $argv $path > /dev/tty"

    _git_fzf_command \
        --flags "--ansi --multi --header='$header' --bind=\"ctrl-space:execute($summary_command)\"" \
        --list-command "git show --format="" --name-status $argv $path | _git_name_status_format" \
        --item-command "cut -d ' ' -f 2,4" \
        --view-command "xargs git show --format="" $argv --"
end

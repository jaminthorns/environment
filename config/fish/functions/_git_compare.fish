function _git_compare_format
    sed -r "s/R[0-9]+/R/" | sed -r "s/\t/ /" | sed -r "s/\t/ ⟶ /"
end

function _git_compare_color_status -a pattern color_name
    set color (set_color $color_name)
    set reset (set_color reset)

    sed -r "s/^($pattern)/$color\1$reset/"
end

function _git_compare_color_statuses
    _git_compare_color_status A green \
        | _git_compare_color_status D red \
        | _git_compare_color_status M yellow \
        | _git_compare_color_status R yellow
end

function _git_compare
    argparse --ignore-unknown "p/path=" -- $argv

    if set -q _flag_path
        set path -- $_flag_path
    end

    _git_fzf_command \
        --fzf-flags "--ansi --multi" \
        --list-command "git diff --stat --name-status $argv $path | _git_compare_format | _git_compare_color_statuses" \
        --item-command "cut -d ' ' -f 2,4" \
        --view-command "xargs git diff $argv --"
end

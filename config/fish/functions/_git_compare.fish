function _git_compare_color_status -a pattern color_name
    set color (set_color $color_name)
    set reset (set_color reset)

    echo "s/^($pattern)/$color\1$reset/"
end

function _git_compare_format
    sed -E \
        -e "s/R[0-9]+/R/" \
        -e "s/\t/ /" \
        -e "s/\t/ ⟶ /" \
        -e (_git_compare_color_status A green) \
        -e (_git_compare_color_status D red) \
        -e (_git_compare_color_status M yellow) \
        -e (_git_compare_color_status R yellow)
end

function _git_compare
    argparse --ignore-unknown "p/path=" -- $argv

    if set -q _flag_path
        set path -- $_flag_path
    end

    set header (git diff --shortstat $argv $path)

    _git_fzf_command \
        --flags "--ansi --multi --header='$header'" \
        --list-command "git diff --stat --name-status $argv $path | _git_compare_format" \
        --item-command "cut -d ' ' -f 2,4" \
        --view-command "xargs git diff $argv --"
end

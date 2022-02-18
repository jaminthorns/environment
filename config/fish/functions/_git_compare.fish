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

    set file_command "echo {} | cut -d ' ' -f 2,4"
    set view_command "$file_command | xargs git diff $argv --"
    set preview_command "$view_command | delta --width \$FZF_PREVIEW_COLUMNS"

    git diff --stat --name-status $argv $path \
        | _git_compare_format \
        | _git_compare_color_statuses \
        | fzf --ansi --no-sort --preview="$preview_command" \
        --bind="alt-enter:execute($view_command)" \
        --bind="enter:execute($file_command)+abort" \
        --bind="double-click:execute($file_command)+abort"
end

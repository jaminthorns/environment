function color_git_name_status -a pattern color_name
    set color (set_color $color_name)
    set reset (set_color reset)

    echo "s/^($pattern)/$color\1$reset/"
end

function format_git_name_status
    sed -E \
        -e "s/R[0-9]+/R/" \
        -e "s/\t/ /" \
        -e "s/\t/ ⟶ /" \
        -e (color_git_name_status A green) \
        -e (color_git_name_status D red) \
        -e (color_git_name_status M yellow) \
        -e (color_git_name_status R blue) \
        -e (color_git_name_status U magenta)
end

# Handle mouse reporting and redirection for executing an external command
function external_command -a command
    set enable_mouse_reporting "printf '\e[?1000h\e[?1006h'"
    set disable_mouse_reporting "printf '\e[?1006l\e[?1000l'"
    set commands "$disable_mouse_reporting" "$command" "$enable_mouse_reporting"

    string replace -r '$' " > /dev/tty" $commands | string join " && "
end

begin
    argparse "flags=" "header=" "list-command=" "item-command=" "view-command=" "summary-command=" -- $argv

    set fzf_command "fzf $_flag_flags"

    if set -q _flag_header
        set -a fzf_command "--header='$_flag_header'"
    end

    set fzf_content_command "echo {} | $_flag_item_command | $_flag_view_command"
    set -a fzf_command "--preview=\"$fzf_content_command | delta --width \\\$FZF_PREVIEW_COLUMNS\""

    set fzf_view_command (external_command $fzf_content_command)
    set -a fzf_command "--bind=\"alt-enter:execute($fzf_view_command)\""

    if set -q _flag_summary_command
        set fzf_summary_command (external_command $_flag_summary_command)
        set -a fzf_command "--bind=\"ctrl-space:execute($fzf_summary_command)\""
    end

    set selected (eval "$_flag_list_command | $fzf_command")
    set fzf_status $status

    if test $fzf_status -eq 0
        string collect $selected | eval $_flag_item_command
    end

    exit $fzf_status
end

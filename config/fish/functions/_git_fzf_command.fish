function _git_fzf_command
    argparse "flags=" "header=" "list-command=" "item-command=" "view-command=" "summary-command=" -- $argv

    set fzf_command "fzf $_flag_flags"

    if set -q _flag_header
        set -a fzf_command "--header='$_flag_header'"
    end

    set fzf_content_command "echo {} | $_flag_item_command | $_flag_view_command"
    set -a fzf_command "--preview=\"$fzf_content_command | delta --width \\\$FZF_PREVIEW_COLUMNS\""
    set -a fzf_command "--bind=\"alt-enter:execute($fzf_content_command > /dev/tty)\""

    if set -q _flag_summary_command
        set -a fzf_command "--bind=\"ctrl-space:execute($_flag_summary_command > /dev/tty)\""
    end

    set list (eval "$_flag_list_command | $fzf_command")
    set fzf_status $status

    if test $fzf_status -eq 0
        string collect $list | eval $_flag_item_command | string join " "
    end

    exit $fzf_status
end

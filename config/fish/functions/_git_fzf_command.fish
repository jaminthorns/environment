function _git_fzf_command
    argparse "flags=" "list-command=" "item-command=" "view-command=" -- $argv

    set fzf_content_command "echo {} | $_flag_item_command | $_flag_view_command"
    set fzf_preview_command "$fzf_content_command | delta --width \\\$FZF_PREVIEW_COLUMNS"
    set fzf_view_command "$fzf_content_command > /dev/tty"
    set fzf_command "fzf $_flag_flags --preview=\"$fzf_preview_command\" --bind=\"alt-enter:execute($fzf_view_command)\""

    set list (eval "$_flag_list_command | $fzf_command")
    set fzf_status $status

    if test $fzf_status -eq 0
        string collect $list | eval $_flag_item_command | string join " "
    end

    exit $fzf_status
end

set -x SEP \u001f

function color_git_name_status -a pattern color_name
    set color (set_color $color_name)
    set reset (set_color reset)

    echo -- -e "s/^(.)($pattern)/\1$color\2$reset/"
    echo -- -e "s/^($pattern)/$color\1$reset/"
end

function format_git_name_status
    sed -E \
        -e "s/R[0-9]+/R/" \
        -e "s/\t/ $SEP/" \
        -e "s/\t/$SEP $(set_color blue)⟶$(set_color reset) $SEP/" \
        (color_git_name_status A green) \
        (color_git_name_status D red) \
        (color_git_name_status M yellow) \
        (color_git_name_status R blue) \
        (color_git_name_status U magenta)
end

function external_command -a command main_view_name delta_flags
    string collect "
    begin
        set -gx DELTA_PAGER less --header=1 --jump-target=2

        for opt in \\\$GIT_FZF_PAGER_OPTS
            set -a DELTA_PAGER \\\$opt
        end

        begin
            set_color --underline cyan
            echo -e '← Back to $main_view_name [q]'
            set_color normal

            $command
        end | delta $delta_flags
    end"
end

begin
    argparse "flags=" "bind=+" "main-view-name=" "items-variable=" "no-items-message=" "header=" "hyperlink-format=" "list-command=" "items-command=" "view-command=" "summary-command=" -- $argv

    set variable_expect alt-v
    set fzf_command "fzf --expect=$variable_expect $_flag_flags"

    for bind in $_flag_bind
        set -a fzf_command "--bind=$bind"
    end

    if not set -q GIT_FZF_SHOW_PREVIEW
        set -a fzf_command "--bind=start:hide-preview"
    end

    if set -q _flag_header
        set -a fzf_command "--header='$_flag_header'"
    end

    if set -q _flag_no_items_message
        set no_items_message $_flag_no_items_message
    else
        set no_items_message "No items selected."
    end

    if set -q _flag_hyperlink_format
        set hyperlink_format_flag "--hyperlinks-file-link-format=$_flag_hyperlink_format"
    end

    set fzf_items_command "set -gx items (echo {} | $_flag_items_command)"

    set fzf_content_command "
    begin
        if test (count \\\$items) -eq 0
            set_color brblack && echo '$no_items_message' | less
        else
            $_flag_view_command
        end
    end"

    set fzf_preview_command "$fzf_items_command; $fzf_content_command | delta --width=\\\$FZF_PREVIEW_COLUMNS $hyperlink_format_flag"
    set -a fzf_command "--preview=\"$fzf_preview_command\""

    set fzf_view_command "$fzf_items_command; $(external_command $fzf_content_command $_flag_main_view_name $hyperlink_format_flag)"
    set -a fzf_command "--bind=\"alt-enter:execute($fzf_view_command)\""

    if set -q _flag_summary_command
        set fzf_summary_command (external_command $_flag_summary_command $_flag_main_view_name)
        set -a fzf_command "--bind=\"alt-space:execute($fzf_summary_command)\""
    end

    set output (eval $_flag_list_command | eval $fzf_command)
    set fzf_status $status

    if test $fzf_status -eq 0
        set completed_key $output[1]
        set selected $output[2..]
        set items (string collect $selected | eval $_flag_items_command)

        switch $completed_key
            case $variable_expect
                set calling_pid (parent_pid (parent_pid $fish_pid))

                set_remote $calling_pid $_flag_items_variable $items
                echo "Selected items stored in $(set_color green)\$$_flag_items_variable$(set_color reset) variable"
            case '*'
                string collect $items
        end
    end

    exit $fzf_status
end

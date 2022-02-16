function _git_history
    argparse --ignore-unknown "f/file=" -- $argv

    if set -q _flag_file
        set file "-- $_flag_file"
    end

    set commit_pattern "[0-9a-f]+"
    set commit_command "echo {} | grep -oE $commit_pattern | head -1"
    set view_command "$commit_command | xargs -I [] git show --color [] $file"
    set preview_command "$view_command | delta --width \$FZF_PREVIEW_COLUMNS"

    git graph --color $argv $_flag_file | fzf --ansi --no-sort --preview="$preview_command" --bind="alt-enter:execute($view_command)" --bind="enter:execute($commit_command)+abort"
end

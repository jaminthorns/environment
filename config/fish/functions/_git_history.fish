function _git_history
    argparse --ignore-unknown "p/path=" -- $argv

    if set -q _flag_path
        set path -- $_flag_path
    end

    set commit_pattern "[0-9a-f]+"
    set commit_command "echo {} | grep -oE $commit_pattern | head -1"
    set view_command "$commit_command | xargs -I [] git show --color [] $path"
    set preview_command "$view_command | delta --width \$FZF_PREVIEW_COLUMNS"

    git graph --color $argv $path | fzf --ansi --no-sort --preview="$preview_command" \
        --bind="alt-enter:execute($view_command)" \
        --bind="enter:execute($commit_command)+abort" \
        --bind="double-click:execute($commit_command)+abort"
end

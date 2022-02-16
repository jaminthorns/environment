function _git_compare
    set view_command "echo {} | xargs -I [] git diff $argv -- []"
    set preview_command "$view_command | delta --width \$FZF_PREVIEW_COLUMNS"

    git diff --stat --name-only $argv | fzf --no-sort --multi --preview="$preview_command" --bind="alt-enter:execute($view_command)"
end

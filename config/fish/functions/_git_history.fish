function _git_history
    argparse --ignore-unknown "f/file=" -- $argv

    if set -q _flag_file
        set file "-- $_flag_file"
    end

    set commit_pattern "[0-9a-f]+"
    set preview_command "echo {} | grep -oE $commit_pattern | head -1 | xargs -I {} git show --color {} $file | delta --width \$FZF_PREVIEW_COLUMNS"

    git graph --color $argv $_flag_file | fzf --reverse --ansi --no-sort --preview $preview_command | grep -oE $commit_pattern | head -1
end

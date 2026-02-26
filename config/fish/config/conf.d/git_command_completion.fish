# Completion for custom Git commands.

complete -c git-todo -k -n "__fish_is_first_arg" -a "(__fish_git_refs)"

complete -c git-sprout -k -n "__fish_is_first_arg" -a "(__fish_git_refs)"

complete -c git-purge-branch -k -n "__fish_is_first_arg" -a "(__fish_git_refs)"

complete -c git-ibranch -w "git branch"
complete -c git-ibranch -s l -l log-options -d "Options for the 'git log' view"

complete -c git-idiff -w "git diff"

complete -c git-ilog -w "git log"
complete -c git-ilog -s s -l show-options -d "Options for the 'git show' view"

complete -c git-ishow -w "git show"

complete -c git-istash -w "git stash list"
complete -c git-istash -s s -l show-options -d "Options for the 'git show' view"

complete -c git-iworktree -w "git worktree list"
complete -c git-iworktree -s s -l status-options -d "Options for the 'git status' view"

# Completion for custom Git commands.

complete -c git-todo -k -n "__fish_is_first_arg" -a "(__fish_git_refs)"

complete -c git-sprout -k -n "__fish_is_first_arg" -a "(__fish_git_refs)"

complete -c git-purge-branch -k -n "__fish_is_first_arg" -a "(__fish_git_refs)"

complete -c git-branches -w "git branch"
complete -c git-branches -s l -l log-options -d "Options for the 'git log' view"

complete -c git-compare -w "git diff"

complete -c git-history -w "git log"
complete -c git-history -s s -l show-options -d "Options for the 'git show' view"

complete -c git-stashes -w "git stash list"
complete -c git-stashes -s s -l show-options -d "Options for the 'git show' view"

complete -c git-view -w "git show"

complete -c git-worktrees -w "git worktree list"
complete -c git-worktrees -s s -l status-options -d "Options for the 'git status' view"

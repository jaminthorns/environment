# Completion for custom Git commands.

complete -c git-todo -k -a "(__fish_git_refs)"

complete -c git-branches -w "git branch"
complete -c git-branches -s l -l log-options -d "Options for the 'git log' view"

complete -c git-compare -w "git diff"
complete -c git-compare -s p -l path -d "Show only changes from specified path"

complete -c git-history -w "git log"
complete -c git-history -s p -l path -d "Show only commits and changes from specified path"
complete -c git-history -s f -l file -d "Show only commits and changes from specified file"
complete -c git-history -s s -l show-options -d "Options for the 'git show' view"

complete -c git-stashes -w "git stash list"
complete -c git-stashes -s s -l show-options -d "Options for the 'git show' view"

complete -c git-view -w "git show"
complete -c git-view -s p -l path -d "Show only changes from specified path"

complete -c git-worktrees -w "git worktree list"
complete -c git-worktrees -s s -l status-options -d "Options for the 'git status' view"

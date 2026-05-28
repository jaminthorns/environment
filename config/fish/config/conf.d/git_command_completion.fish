# Completion for custom Git commands.

complete -c git-todo -k -n "__fish_is_first_arg" -a "(__fish_git_refs)"

complete -c git-onto -k -n "__fish_is_first_arg" -a "(__fish_git_refs)"
complete -c git-onto -s c -l create-branch -r -d "Create a new branch"

complete -c git-purge-branch -k -n "__fish_is_first_arg" -a "(__fish_git_refs)"

complete -c git-branch-range -k -n "__fish_is_first_arg" -a "(__fish_git_commits)"
complete -c git-branch-range -s t -l target -r -d "Target ref that branch is merged into" -a "(__fish_git_refs)"

complete -c git-ibranch -w "git branch"
complete -c git-ibranch -s l -l log-options -r -d "Options for the 'git log' view"

complete -c git-idiff -w "git diff"

complete -c git-ilog -w "git log"
complete -c git-ilog -s s -l show-options -r -d "Options for the 'git show' view"

complete -c git-ishow -w "git show"

complete -c git-istash -w "git stash list"
complete -c git-istash -s s -l show-options -r -d "Options for the 'git show' view"

complete -c git-iworktree -w "git worktree list"
complete -c git-iworktree -s s -l status-options -r -d "Options for the 'git status' view"

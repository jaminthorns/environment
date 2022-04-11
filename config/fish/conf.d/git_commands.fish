complete -c git-branches -w "git branch"
complete -c git-compare -w "git diff"
complete -c git-history -w "git log"
complete -c git-stashes -w "git stash"
complete -c git-view -w "git show"

complete -c git-compare -s p -l path -d "Show only changes from specified path"
complete -c git-history -s p -l path -d "Show only commits and changes from specified path"
complete -c git-view -s p -l path -d "Show only changes from specified path"

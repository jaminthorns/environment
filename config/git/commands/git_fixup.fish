if set -q argv[2]
    set commit (git rev-parse $argv[2])
else
    set commit (git rev-parse HEAD)
end

switch $argv[1]
    case fixup
        git commit --fixup=$commit
    case amend
        git commit --fixup=amend:$commit
    case reword
        git commit --fixup=reword:$commit
end

if not test -z (git status --porcelain | string collect)
    set should_stash
end

if set -q should_stash
    git stash --include-untracked
end

git rebase --autosquash $commit~

if set -q should_stash
    git stash pop --index
end

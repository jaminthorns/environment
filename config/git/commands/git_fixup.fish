if set -q argv[2]
    set commit $argv[2]
else
    set commit (git rev-parse HEAD)
end

if not test -z (git status --porcelain | string collect)
    set should_stash
end

switch $argv[1]
    case fixup
        set stash_opts --keep-index
        set fixup_value $commit
    case amend
        set stash_opts --keep-index
        set fixup_value amend:$commit
    case reword
        set fixup_value reword:$commit
end

if set -q should_stash
    git stash $stash_opts
end

git commit --fixup=$fixup_value
git rebase --autosquash $commit~

if set -q should_stash
    git stash pop
end

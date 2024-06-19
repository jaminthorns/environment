for repository in ~/Projects/*
    echo -n $repository

    if test -d $repository/.git
        set branch (git -C $repository branch --show-current)
        echo -n " - $branch"
    end

    echo
end

function option_args
    set index (contains -i -- -- $argv)

    if test $status -eq 0
        set before_index (math max 1, (math $index - 1))
        string collect -- $argv[..$before_index]
    else
        string collect -- $argv
    end
end

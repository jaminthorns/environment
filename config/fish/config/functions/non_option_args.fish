function non_option_args
    set index (contains -i -- -- $argv)

    if test $status -eq 0
        set after_index (math $index + 1)
        string collect -- $argv[$after_index..]
    end
end

function lf --wraps lf
    set output (command lf -print-last-dir $argv 2>&1)

    if test $output[1] = lf_change_directory
        cd $output[2]
    end
end

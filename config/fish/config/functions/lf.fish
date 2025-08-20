function lf --wraps lf
    set -x lf_quit_operation_path (mktemp)
    set last_dir_path (mktemp)

    command lf -last-dir-path=$last_dir_path $argv

    switch (cat $lf_quit_operation_path)
        case change_directory
            cd (cat $last_dir_path)
    end

    rm $lf_quit_operation_path $last_dir_path
end

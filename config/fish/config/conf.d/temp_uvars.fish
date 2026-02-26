# Provide functionality for storing data in temporary universal variables.

function create_temp_uvar
    set uuid (uuidgen | string replace -a - _)
    set store_var _temp_{$fish_pid}_$uuid

    echo $store_var
end

function clean_temp_uvars
    for store_var in (set -U | string split -f 1 " " | string match "_temp_*")
        set pid (string match -r -g "_temp_(\d+)" $store_var)

        if not ps -p $pid >/dev/null
            set -U -e $store_var
        end
    end
end

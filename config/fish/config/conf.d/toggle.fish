# Provide functionality for maintaining a process-level store for toggles.

function create_toggles
    set store_var _toggles_(uuidgen | string replace -a - _)
    set -U $store_var
    echo $store_var
end

function toggle -a store_var toggle_name
    if set toggle_index (contains -i $toggle_name $$store_var)
        set -e {$store_var}[$toggle_index]
    else
        set -a $store_var $toggle_name
    end

    return 0
end

function enabled -a store_var toggle_name
    if test (count $toggle_name) -eq 0
        string collect $$store_var
    else
        contains $toggle_name $$store_var
    end
end

function delete_toggles -a store_var
    set -U -e $store_var
end

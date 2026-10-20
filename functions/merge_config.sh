function merge_config {
    local config_path=$1
    local destination_path=$2
    local merged

    if test -z "$3"; then
        merged=$(read_config "$config_path" | diff3 -m -L config -L evaluated -L destination "$config_path" - "$destination_path")
    else
        merged=$(diff3 -m -L config -L evaluated -L destination "$config_path" "$3" "$destination_path")
    fi

    echo "$merged" > "$config_path"
}

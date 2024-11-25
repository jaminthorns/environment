function merge_config {
    local config_path=$1
    local dest_path=$2
    local merged=$(read_config "$config_path" | diff3 -m -L config -L evaluated -L destination "$config_path" - "$dest_path")

    echo "$merged" > "$config_path"
}

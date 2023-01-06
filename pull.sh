#!/usr/bin/env bash

source functions/config_paths.sh
source functions/read_config.sh
source functions/run_script.sh

function copy {
  local config_path dest_path
  local paths=$(config_paths "$1" "$2")

  while read -r config_path dest_path; do
    local labels="-L config -L evaluated -L destination"
    local merged=$(read_config "$config_path" | diff3 -m $labels "$config_path" - "$dest_path")

    echo "$merged" > "$config_path"
  done <<< "$paths"
}

function on_push {
  :
}

function on_pull {
  run_script "$1"
}

(cd config && source sync.sh)

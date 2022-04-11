#!/usr/bin/env bash

source functions/config_paths.sh
source functions/read_config.sh
source functions/run_script.sh

function copy {
  local config_path dest_path
  local paths=$(config_paths "$1" "$2")

  while read -r config_path dest_path; do
    local config_file=$(read_config "$config_path")
    local dest_file=$(cat "$dest_path")

    if [ "$config_file" != "$dest_file" ]; then
      echo "$dest_file" > "$config_path"
    fi
  done <<< "$paths"
}

function run {
  run_script "$2"
}

(cd config && source sync.sh)

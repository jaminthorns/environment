#!/usr/bin/env bash

source functions/config_paths.sh
source functions/read_config.sh
source functions/run_script.sh

function copy {
  local config_path dest_path
  local paths=$(config_paths "$1" "$2")

  while read -r config_path dest_path; do
    local dest_parent_dir=$(dirname "$dest_path")
    local config_file=$(read_config "$config_path")

    mkdir -p "$dest_parent_dir" && echo "$config_file" > "$dest_path"
  done <<< "$paths"
}

function run {
  run_script "$1"
}

(cd config && source sync.sh)

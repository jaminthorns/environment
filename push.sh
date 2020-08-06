#!/bin/bash

source functions/config_paths.sh
source functions/read_config.sh

function copy {
  local config_path dest_path
  local paths=$(config_paths "$1" "$2")

  while read config_path dest_path; do
    dest_parent_dir=$(dirname "$dest_path")
    config_file=$(read_config "$config_path")

    mkdir -p "$dest_parent_dir" && echo "$config_file" > "$dest_path"
  done <<< "$paths"
}

function run {
  local script_path=$2
  local script_dir=$(dirname "$script_path")
  local script_name=$(basename "$script_path")

  (cd "$script_dir" && source "$script_name")
}

(cd config && source sync.sh)

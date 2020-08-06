#!/bin/bash

source functions/config_paths.sh
source functions/read_config.sh

function copy {
  local config_path dest_path
  local paths=$(config_paths "$1" "$2")

  while read config_path dest_path; do
    config_file=$(read_config "$config_path")
    dest_file=$(cat "$dest_path")

    if [ "$config_file" != "$dest_file" ]; then
      echo "$dest_file" > "$config_path"
    fi
  done <<< "$paths"
}

function run {
  local script_path=$1
  local script_dir=$(dirname "$script_path")
  local script_name=$(basename "$script_path")

  (cd "$script_dir" && source "$script_name")
}

(cd config && source sync.sh)

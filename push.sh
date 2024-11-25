#!/usr/bin/env bash

source functions/config_functions.sh
source functions/config_paths.sh
source functions/run_script.sh

function copy {
  local config_path dest_path
  local paths=$(config_paths "$1" "$2")

  while IFS="|" read -r config_path dest_path; do
    mkdir -p "$(dirname "$dest_path")" && read_config "$config_path" > "$dest_path"
  done <<< "$paths"
}

function on_push {
  run_script "$1"
}

function on_pull {
  :
}

(cd config && source sync.sh)

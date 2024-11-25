#!/usr/bin/env bash

source functions/config_functions.sh
source functions/config_paths.sh
source functions/run_script.sh

function copy {
  local config_path dest_path
  local paths=$(config_paths "$1" "$2")

  while IFS="|" read -r config_path dest_path; do
    merge_config "$config_path" "$dest_path"
  done <<< "$paths"
}

function on_push {
  :
}

function on_pull {
  run_script "$1"
}

(cd config && source sync.sh)

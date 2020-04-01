#!/bin/bash

source functions/config_paths.sh
source functions/read_config.sh
source secrets/values

while read config_path home_path; do
  config_file=$(read_config $config_path)
  home_file=$(cat $home_path)

  if [ "$config_file" != "$home_file" ]; then
    echo "$home_file" > $config_path
  fi
done <<< "$(config_paths config $HOME)"

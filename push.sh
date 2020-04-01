#!/bin/bash

source functions/config_paths.sh
source functions/read_config.sh
source secrets/values

while read config_path home_path; do
  home_folder=$(dirname $home_path)
  config_file=$(read_config $config_path)

  mkdir -p $home_folder && echo "$config_file" > $home_path
done <<< "$(config_paths config $HOME)"

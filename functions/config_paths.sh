#!/bin/bash

function config_paths {
  local config_dir=$1
  local home_dir=$2

  for config_group in $(ls $config_dir); do
    config_group_dir=$config_dir/$config_group

    for path in $(cd $config_group_dir && find . -type f); do
      echo $config_group_dir/$path $home_dir/$path
    done
  done
}

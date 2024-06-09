function config_paths {
  local path
  local config_dir=$1
  local dest_dir=$2

  for path in $(cd "$config_dir" && find . -type f); do
    echo "$config_dir/$path|$dest_dir/$path"
  done
}

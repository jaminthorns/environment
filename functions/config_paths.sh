function config_paths {
  local path
  local config_dir=$1
  local dest_dir=$2

  while IFS= read -r -d "" path; do
    echo "$config_dir/$path|$dest_dir/$path"
  done < <(cd "$config_dir" && find . -type f -print0)
}

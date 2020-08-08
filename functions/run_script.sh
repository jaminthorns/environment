function run_script {
  local script_path=$1
  local script_dir=$(dirname "$script_path")
  local script_name=$(basename "$script_path")

  (cd "$script_dir" && source "$script_name")
}

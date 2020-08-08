function create_secrets {
  local variable value
  local variables_path=$1
  local values_path=$2

  for variable in $(cat $variables_path); do
    read -p "$variable: " value
    echo "$variable=$value" >> $values_path
  done
}

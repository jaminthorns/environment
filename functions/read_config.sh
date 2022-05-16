function read_config {
  local substitution
  local file=$(cat "$1")
  local substitutions=$(grep -o "{{\([^}]\|}[^}]\)*}}" <<< "$file")

  if test -n "$substitutions"; then
    while read -r substitution; do
      local command=${substitution/#"{{"}
      local command=${command/%"}}"}
      local value=$(eval $command)

      local file=${file/"$substitution"/$value}
    done <<< "$substitutions"
  fi

  echo "$file"
}

#!/bin/bash

function read_config {
  local substitution
  local file=$(cat "$1")
  local substitutions=$(grep -o "{{\([^}]\|}[^}]\)*}}" <<< "$file")

  if [ -n "$substitutions" ]; then
    while read substitution; do
      local command=${substitution/#"{{"}
      local command=${command/%"}}"}
      local value=$(eval $command)

      local file=${file/"$substitution"/$value}
    done <<< "$substitutions"
  fi

  echo "$file"
}

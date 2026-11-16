function filter_values() {
  local values=$1
  local filters_path=$2
  local line_function=$3

  local section=
  local key=
  local filters=$(cat $filters_path)

  while IFS= read -r line; do
    local section_line=0
    local key_line=0

    if [[ $line =~ ^\[(.+)\]$ ]]; then
      section_line=1
      section=${BASH_REMATCH[1]}
    elif [[ $line =~ ^(.*)= ]]; then
      key_line=1
      key=${BASH_REMATCH[1]}
    fi

    $line_function "$line" "$section_line" "$section" "$key_line" "$key" "$filters"
  done <<< "$values"
}

function include_line() {
  local line=$1
  local section_line=$2
  local section=$3
  local key_line=$4
  local key=$5
  local includes=$6

  local include=0

  while IFS=":" read -r include_section include_key; do
    if [[ $section = $include_section ]]; then
      if [[ $section_line = 1 ]]; then include=1; break; fi
      if [[ $key_line = 1 && $section = $include_section && $key = $include_key ]]; then include=1; break; fi
      if [[ $section_line = 0 && $key_line = 0 ]]; then include=1; break; fi
    fi
  done <<< "$includes"

  if [[ $include = 1 ]]; then
    echo $line
  fi
}

function exclude_line() {
  local line=$1
  local section_line=$2
  local section=$3
  local key_line=$4
  local key=$5
  local excludes=$6

  local exclude=0

  while IFS=":" read -r exclude_section exclude_key; do
    if [[ $section = $exclude_section ]]; then
      if [[ $key = "*" ]]; then exclude=1; break; fi
      if [[ $key_line = 1 && $section = $exclude_section && $key = $exclude_key ]]; then exclude=1; break; fi
    fi
  done <<< "$excludes"

  if [[ $exclude = 0 ]]; then
    echo $line
  fi
}

for file in $(ls -I "*.exclude" -I "*.include" schemas); do
  local schema=$(basename -s .ini $file)
  local path=/$(echo $schema | sed -e 's/\./\//g')/
  local values=$(dconf dump $path)

  local print=0

  if [[ -e schemas/$schema.include ]]; then
    values=$(filter_values "$values" "schemas/$schema.include" include_line)
  fi

  if [[ -e schemas/$schema.exclude ]]; then
    values=$(filter_values "$values" "schemas/$schema.exclude" exclude_line)
  fi

  echo "$values" > schemas/$file
done

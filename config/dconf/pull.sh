for schema in $(ls schemas); do
  local path=$(basename -s .ini $schema | sed -e 's/\./\//g')

  if test -f schemas/$schema; then
    dconf dump /$path/ > schemas/$schema
  else
    for value in $(ls schemas/$schema); do
      dconf read /$path/$value > schemas/$schema/$value
    done
  fi
done

for file in $(ls -I "*.exclude" -I "*.include" schemas); do
  local path=/$(basename -s .ini $file | sed -e 's/\./\//g')/

  dconf load $path < schemas/$file
done

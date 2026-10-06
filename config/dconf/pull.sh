for file in $(ls schemas); do
  local path=$(basename -s .ini $file | sed -e 's/\./\//g' -e 's/.*/\/&\//')
  dconf dump $path > schemas/$file
done

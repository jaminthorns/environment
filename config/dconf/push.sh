for file in $(ls schemas); do
  local path=$(basename -s .ini $file | sed -e 's/\./\//g' -e 's/.*/\/&\//')
  dconf load $path < schemas/$file
done

for file in $(ls values); do
  local path=$(echo $file | sed -e 's/\./\//g' -e 's/.*/\/&/')
  dconf write $path "$(cat values/$file)"
done

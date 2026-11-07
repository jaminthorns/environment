for file in $(ls schemas); do
  local path=$(basename -s .ini $file | sed -e 's/\./\//g' -e 's/.*/\/&\//')
  dconf dump $path > schemas/$file
done

for file in $(ls values); do
  local path=$(echo $file | sed -e 's/\./\//g' -e 's/.*/\/&/')
  dconf read $path > values/$file
done

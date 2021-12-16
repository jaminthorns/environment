local_dir=$1

function read_local {
  local path=$local_dir/$1

  if [ ! -e $path ]; then
    touch $path
  fi

  read_config $path
}

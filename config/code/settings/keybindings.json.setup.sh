function key {
  if os_status mac-os; then
    echo $1
  else
    echo $2
  fi
}

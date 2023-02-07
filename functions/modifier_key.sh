function modifier_key {
  if os_status mac-os; then
    test "$1" = "upper" && echo "CMD" || echo "cmd"
  else
    test "$1" = "upper" && echo "CTRL" || echo "ctrl"
  fi
}

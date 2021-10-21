function modifier_key {
  if os_status mac-os; then
    echo cmd
  else
    echo ctrl
  fi
}

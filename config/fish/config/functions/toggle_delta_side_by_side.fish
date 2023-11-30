function toggle_delta_side_by_side --on-signal WINCH --on-event fish_postexec
  if test (tput cols) -gt 120
      set -gx DELTA_FEATURES "+side-by-side"
  else
      set -e DELTA_FEATURES
  end
end

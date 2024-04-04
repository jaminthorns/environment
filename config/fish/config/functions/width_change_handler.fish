function width_change_handler --on-signal WINCH --on-event fish_postexec
    if test (tput cols) -gt $WIDTH_BREAKPOINT
        set -gx DELTA_FEATURES "+side-by-side"
        set -gx GIT_FZF_SHOW_PREVIEW
    else
        set -e DELTA_FEATURES
        set -e GIT_FZF_SHOW_PREVIEW
    end
end

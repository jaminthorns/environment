function width_change_handler --on-signal WINCH --on-event fish_postexec
    set DELTA_FEATURES (string split " " $DELTA_FEATURES)

    if test (tput cols) -gt $WIDTH_BREAKPOINT
        if not contains side-by-side $DELTA_FEATURES
            set -a DELTA_FEATURES side-by-side
        end

        set -gx GIT_FZF_SHOW_PREVIEW
    else
        if set index (contains -i side-by-side $DELTA_FEATURES)
            set -e DELTA_FEATURES[$index]
        end

        set -e GIT_FZF_SHOW_PREVIEW
    end
end

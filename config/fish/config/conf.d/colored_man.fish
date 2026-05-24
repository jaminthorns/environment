# Wrapper for `man` to set colors.

functions -c man __man

function man --wraps man
    # Disable SGR output in groff so LESS_TERMCAP_* variables work
    set -x GROFF_NO_SGR 1

    set -x LESS_TERMCAP_md (set_color -o blue) # Start bold
    set -x LESS_TERMCAP_me (set_color normal) # End bold
    set -x LESS_TERMCAP_us (set_color -u cyan) # Start underline
    set -x LESS_TERMCAP_ue (set_color normal) # End underline

    __man $argv
end

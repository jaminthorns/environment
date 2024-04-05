function man --wraps man
    set -x LESS_TERMCAP_md (set_color -o blue) # Start bold
    set -x LESS_TERMCAP_me (set_color normal) # End bold
    set -x LESS_TERMCAP_us (set_color -u cyan) # Start underline
    set -x LESS_TERMCAP_ue (set_color normal) # End underline

    command man $argv
end

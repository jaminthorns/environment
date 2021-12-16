if status is-login
    # Initialize Homebrew
    {{unset HOMEBREW_SHELLENV_PREFIX && fish -c "brew shellenv"}}
end

if status is-interactive
    # Disable greeting
    set fish_greeting

    # pisces config
    set pisces_only_insert_at_eol 1

    # Editor
    set -x EDITOR code

    # Pager
    set -x PAGER less

    # less options
    set -x LESS -SRc~

    # Erlang flags
    set -x ERL_AFLAGS -kernel shell_history enabled

    # bat config
    set -x BAT_PAGER less $LESS
    set -x BAT_THEME Dracula

    # fzf config
    set -l fzf_colors "fg:-1,fg+:-1,bg:-1,bg+:-1,hl:cyan,hl+:cyan,info:blue,marker:blue,pointer:blue,prompt:green,border:bright-black"
    set -x FZF_DEFAULT_OPTS "--reverse --no-info --prompt='▶ ' --pointer='▶' --marker='•' --color $fzf_colors"

    # fzf.fish keybindings
    fzf_configure_bindings --directory=\cT --history=\cR --variables=\cB --git_status --git_log
end

# Initialize asdf
source {{brew --prefix asdf}}/asdf.fish

{{read_local config.fish}}

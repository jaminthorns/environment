if status is-login
    # Initialize Homebrew
    {{fish -c "brew shellenv"}}

    # Initialize asdf
    source {{brew --prefix asdf}}/asdf.fish

    # Enable global Yarn packages
    set -p PATH {{yarn global bin}}
end

if status is-interactive
    # Disable greeting
    set fish_greeting

    # pisces options
    set pisces_only_insert_at_eol 1

    # less options
    set -x LESS -SRc~

    # Erlang options
    set -x ERL_AFLAGS -kernel shell_history enabled

    # bat options
    set -x BAT_PAGER less $LESS
    set -x BAT_THEME Dracula

    # fzf options
    set -l fzf_colors "fg:-1,fg+:-1,bg:-1,bg+:-1,hl:6,hl+:6,spinner:4,info:4,marker:4,pointer:2,prompt:2"
    set -x FZF_DEFAULT_OPTS "--reverse --no-info --height 50% --color $fzf_colors"
end

# Secrets
test -e $HOME/.secrets.fish && source $HOME/.secrets.fish

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

    # less options
    set -x LESS "--RAW-CONTROL-CHARS --use-color --ignore-case --chop-long-lines --clear-screen --tilde --shift=.1"

    # Pager
    set -x PAGER less $LESS

    # Erlang flags
    set -x ERL_AFLAGS -kernel shell_history enabled

    # bat config
    set -x BAT_PAGER $PAGER
    set -x BAT_THEME Dracula

    # fzf config
    set -l fzf_colors "bg+:#44475A,gutter:-1,hl:cyan,hl+:cyan,info:blue,marker:blue,pointer:blue,prompt:green,border:blue,header:bright-black"
    set -x FZF_DEFAULT_OPTS "--reverse --no-info --preview-window=border-sharp --prompt='▶ ' --pointer='▶' --marker='•' --color=$fzf_colors"

    # fzf.fish keybindings
    fzf_configure_bindings --directory=\cT --history=\cR --variables=\cB --processes=\cG --git_status --git_log
end

# Initialize asdf
source {{brew --prefix asdf}}/asdf.fish

# Enable git commands
set -p PATH {{git rev-parse --show-toplevel}}/config/git/commands

{{read_local config.fish}}

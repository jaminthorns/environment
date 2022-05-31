if status is-login
    # Initialize Homebrew
    {{unset HOMEBREW_SHELLENV_PREFIX && fish -c "brew shellenv"}}
end

if status is-interactive
    # Disable greeting
    set fish_greeting

    # Enable alternate scroll mode
    printf "\e[?1007h"

    # Set editor to Visual Studio Code
    set -x EDITOR code

    # Configure less
    set -x LESS "--RAW-CONTROL-CHARS --use-color --ignore-case --chop-long-lines --clear-screen --tilde --shift=.1"

    # Set pager to less
    set -x PAGER less $LESS

    # Set true color support
    set -x COLORTERM truecolor

    # Configure Erlang
    set -x ERL_AFLAGS -kernel shell_history enabled

    # Configure bat
    set -x BAT_PAGER $PAGER
    set -x BAT_THEME Dracula

    # Configure fzf
    set -l fzf_colors "bg+:#44475A,gutter:-1,hl:cyan,hl+:cyan,info:blue,marker:blue,pointer:blue,prompt:green,border:blue,header:bright-black"
    set -x FZF_DEFAULT_OPTS "--reverse --no-info --preview-window=border-sharp --prompt='▶ ' --pointer='▶' --marker='•' --color=$fzf_colors"

    # Configure fzf.fish keybindings
    fzf_configure_bindings --directory=\cT --history=\cR --variables=\cB --processes=\cG --git_status --git_log

    # Customize Tide prompt
    set -x tide_status_icon ✓
    set -x tide_status_icon_failure ✕
end

# Initialize asdf
source {{brew --prefix asdf}}/asdf.fish

# Enable git commands
set -p PATH {{git rev-parse --show-toplevel}}/config/git/commands

{{read_local config.fish}}

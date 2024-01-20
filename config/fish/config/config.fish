if status is-login
    # Initialize Homebrew
    {{export PATH="/dev/null:$PATH" && brew shellenv fish}}

    # Initialize asdf
    source {{brew --prefix asdf}}/libexec/asdf.fish

    # Add Git commands to PATH
    set -p PATH {{git rev-parse --show-toplevel}}/config/git/commands
end

if status is-interactive
    # Set theme
    fish_config theme choose "Dracula Official"

    # Disable greeting
    set -g fish_greeting

    # Set editor to Visual Studio Code
    set -gx EDITOR code

    # Configure less
    set -gx LESS --RAW-CONTROL-CHARS --use-color --ignore-case --chop-long-lines --clear-screen --tilde --shift=.1

    # Set pager to less
    set -gx PAGER less $LESS

    # Set true color support
    set -gx COLORTERM truecolor

    # Configure Erlang
    set -gx ERL_AFLAGS -kernel shell_history enabled
    set -gx KERL_BUILD_DOCS yes

    # Configure bat
    set -gx BAT_PAGER $PAGER
    set -gx BAT_THEME Dracula

    # Configure delta features
    set -gx DELTA_SIDE_BY_SIDE_BREAKPOINT 120

    # Configure fzf
    set -l fzf_prompt "▶ "
    set -l fzf_colors "bg+:#44475A,gutter:-1,hl:cyan,hl+:cyan,info:blue,marker:magenta,pointer:white,spinner:green,prompt:green,border:blue,header:bright-black"
    set -gx FZF_DEFAULT_OPTS --reverse --no-info --preview-window=border-sharp \
        --bind="esc:cancel" \
        --bind="ctrl-a:select-all" \
        --bind="ctrl-p:toggle-preview" \
        --prompt=(string escape $fzf_prompt) \
        --pointer=(string escape "▶") \
        --marker=(string escape "█ ") \
        --ellipsis=(string escape "…") \
        --color=$fzf_colors

    # Configure fzf.fish
    set -g fzf_history_time_format "%F %r"
    set -g fzf_directory_opts --prompt="Files $fzf_prompt" --bind="alt-enter:replace-query"
    set -g fzf_history_opts --prompt="History $fzf_prompt"
    set -g fzf_variables_opts --prompt="Variables $fzf_prompt"
    set -g fzf_processes_opts --prompt="Processes $fzf_prompt"
    set -g fzf_fd_opts --unrestricted --exclude=.git
    set -l fzf_preview_cmd "preview --width=\$FZF_PREVIEW_COLUMNS --height=\$FZF_PREVIEW_LINES"
    set -gx fzf_preview_dir_cmd $fzf_preview_cmd
    set -gx fzf_preview_file_cmd $fzf_preview_cmd
    fzf_configure_bindings --directory=\cT --history=\cR --variables=\cB --processes=\cG --git_status --git_log

    # Customize Tide prompt
    set -gx tide_character_icon ▶
    set -gx tide_left_prompt_items pwd git
    set -gx tide_right_prompt_items status cmd_duration context jobs
    set -gx tide_status_icon ✓
    set -gx tide_status_icon_failure ✕
    set -gx tide_jobs_icon ⋯
    set -gx tide_git_truncation_length 50

    # Configure man page colors
    set -g man_blink -o red
    set -g man_bold -o blue
    set -g man_standout -r
    set -g man_underline -u cyan
end

# In a terminal or some process started by a terminal
if set -q TERM
    # Toggle delta side-by-side view based on terminal width
    toggle_delta_side_by_side
end

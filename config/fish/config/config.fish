if status is-login
    # Initialize Homebrew
    {{export PATH="/dev/null:$PATH" && brew shellenv fish}}

    # Add local binaries to PATH
    fish_add_path -gP $HOME/.local/bin

    # Add asdf shims to PATH
    fish_add_path -gP $HOME/.asdf/shims

    # Add Git commands to PATH
    fish_add_path -gP {{git rev-parse --show-toplevel}}/config/git/commands
end

if status is-interactive
    # Set theme
    fish_config theme choose "Dracula Official"

    # Disable greeting
    set -g fish_greeting

    # Set editor to Visual Studio Code
    if set -q TERM_PROGRAM && test $TERM_PROGRAM = vscode
        set -gx EDITOR code --wait
    else
        set -gx EDITOR code --wait --new-window
    end

    # Configure less if not configured from parent shell
    if not set -q LESS
        set -gx LESS --RAW-CONTROL-CHARS --use-color --ignore-case --chop-long-lines --clear-screen --tilde --shift=20
    end

    # Set pager to less
    set -gx PAGER less

    # Configure Homebrew
    set -gx HOMEBREW_NO_AUTOREMOVE 1

    # Configure Erlang
    set -gx ERL_AFLAGS -kernel shell_history enabled
    set -gx KERL_BUILD_DOCS yes

    # Configure bat
    set -gx BAT_THEME Dracula
    set -gx BAT_PAGING always

    # Configure Delta
    set -gx DELTA_FEATURES +

    # Configure width breakpoint
    set -gx WIDTH_BREAKPOINT 120

    # Configure lf
    if {{os_status wsl && echo true || echo false}}
        set -gx OPENER windows_open
    end

    # Configure fzf
    set -l fzf_scrollbar_color "#363848" # Selection color blended 50% with background color
    set -l fzf_colors \
        "bg+:#44475A" \
        "gutter:-1" \
        "hl:cyan" \
        "hl+:cyan" \
        "info:blue" \
        "marker:magenta" \
        "spinner:green" \
        "prompt:green" \
        "border:blue" \
        "scrollbar:$fzf_scrollbar_color" \
        "preview-scrollbar:$fzf_scrollbar_color" \
        "header:bright-black" \
        "footer:bright-black"
    set -gx FZF_DEFAULT_OPTS \
        --reverse \
        --info=inline-right \
        --no-separator \
        --highlight-line \
        --footer-border=none \
        --preview-window=border-left \
        --prompt=(string escape "▶ ") \
        --pointer= \
        --marker=▌ \
        --marker-multi-line=▌▌▌ \
        --ellipsis=… \
        --scrollbar=█ \
        --bind=esc:cancel \
        --bind=alt-p:toggle-preview \
        --bind=alt-up:page-up \
        --bind=alt-down:page-down \
        --bind=alt-shift-up:first \
        --bind=alt-shift-down:last \
        --color=(string join , $fzf_colors)

    # Configure fzf.fish
    set -g fzf_history_time_format "%F %r"
    set -g fzf_directory_opts --prompt=(render_prompt Files) --bind=alt-enter:replace-query
    set -g fzf_history_opts --prompt=(render_prompt History) --preview-window=border-top
    set -g fzf_variables_opts --prompt=(render_prompt Variables)
    set -g fzf_processes_opts --prompt=(render_prompt Processes) --preview-window=border-top
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
end

# In a terminal or some process started by a terminal
if set -q TERM
    width_change_handler
end

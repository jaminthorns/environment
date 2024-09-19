if status is-login
    # Initialize Homebrew
    {{export PATH="/dev/null:$PATH" && brew shellenv fish}}

    # Initialize asdf
    source {{brew --prefix asdf}}/libexec/asdf.fish

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

    # Configure less
    set -gx LESS --RAW-CONTROL-CHARS --use-color --ignore-case --chop-long-lines --clear-screen --tilde --shift=20

    # Set pager to less
    set -gx PAGER less

    # Configure Erlang
    set -gx ERL_AFLAGS -kernel shell_history enabled
    set -gx KERL_BUILD_DOCS yes

    # Configure bat
    set -gx BAT_THEME Dracula
    set -gx BAT_PAGING always

    # Configure Delta
    set -gx DELTA_PAGER less --jump-target=2
    set -gx DELTA_FEATURES +

    # Configure width breakpoint
    set -gx WIDTH_BREAKPOINT 120

    # Configure Git fzf commands
    if set -q GITTERM_SEARCH
        set -gx GIT_FZF_PAGER_OPTS --jump-target=.5 --pattern=(string escape $GITTERM_SEARCH)
    end

    # Configure lf
    if {{os_status wsl && echo true || echo false}}
        set -gx OPENER wslview
    end

    # Configure fzf
    set -l fzf_prompt "▶ "
    set -l fzf_colors "bg+:#44475A,gutter:-1,hl:cyan,hl+:cyan,info:blue,marker:magenta,spinner:green,prompt:green,border:blue,scrollbar:bright-black,preview-scrollbar:bright-black,header:bright-black"
    set -gx FZF_DEFAULT_OPTS --reverse --no-info --no-separator --highlight-line --preview-window=border-left \
        --bind="esc:cancel" \
        --bind="ctrl-a:select-all" \
        --bind="ctrl-p:toggle-preview" \
        --pointer=(string escape " ") \
        --prompt=(string escape $fzf_prompt) \
        --ellipsis=(string escape "…") \
        --color=$fzf_colors

    # Configure fzf.fish
    set -g fzf_history_time_format "%F %r"
    set -g fzf_directory_opts --prompt="Files $fzf_prompt" --bind="alt-enter:replace-query"
    set -g fzf_history_opts --prompt="History $fzf_prompt" --preview-window=border-top
    set -g fzf_variables_opts --prompt="Variables $fzf_prompt"
    set -g fzf_processes_opts --prompt="Processes $fzf_prompt" --preview-window=border-top
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

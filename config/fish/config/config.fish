if status is-login
    # Initialize Homebrew
    {{fish -c "set -p PATH /dev/null && brew shellenv"}}

    # Initialize asdf
    source {{brew --prefix asdf}}/libexec/asdf.fish

    # Enable git commands
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

    # Configure filetype colors
    set -gx LS_COLORS "{{vivid generate dracula}}"

    # Configure bat
    set -gx BAT_PAGER $PAGER
    set -gx BAT_THEME Dracula

    # Configure fzf
    set -l fzf_prompt "▶ "
    set -l fzf_colors "bg+:#44475A,gutter:-1,hl:cyan,hl+:cyan,info:blue,marker:blue,pointer:blue,prompt:green,border:blue,header:bright-black"
    set -gx FZF_DEFAULT_OPTS --reverse --no-info --preview-window=border-sharp --bind="esc:cancel" --bind="ctrl-p:toggle-preview" --prompt=(string escape $fzf_prompt) --pointer=▶ --marker=⏽ --color=$fzf_colors

    # Configure fzf.fish
    set -g fzf_directory_opts --prompt="Files $fzf_prompt" --bind="alt-enter:replace-query"
    set -g fzf_history_opts --prompt="History $fzf_prompt"
    set -g fzf_variables_opts --prompt="Variables $fzf_prompt"
    set -g fzf_processes_opts --prompt="Processes $fzf_prompt"
    set -g fzf_fd_opts --unrestricted --exclude=.git
    set -l fzf_preview_cmd "preview --embedded --width=\$FZF_PREVIEW_COLUMNS --height=\$FZF_PREVIEW_LINES"
    set -gx fzf_preview_dir_cmd $fzf_preview_cmd
    set -gx fzf_preview_file_cmd $fzf_preview_cmd
    fzf_configure_bindings --directory=\cT --history=\cR --variables=\cB --processes=\cG --git_status --git_log

    # Customize Tide prompt
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

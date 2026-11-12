function send_to_device
    argparse full-screen -- $argv

    set gsconnect "$HOME/.local/share/gnome-shell/extensions/gsconnect@andyholmes.github.io/service/daemon.js"

    set devices ($gsconnect --list-devices)

    if test (count $devices) -eq 0
        echo "No devices available." >&2
        return 1
    else
        if not set -q _flag_full_screen
            set fzf_flags --height=~100%
        end

        set device_name ($gsconnect --list-all | string match --entire -r (string join "|" $devices) | string split \t -f 2 | fzf --prompt=(render_prompt Devices) $fzf_flags)

        if test $status -eq 0
            for file in $argv
                if not test -f $file
                    echo "All paths must be files." >&2
                    return 2
                end

                set -a file_flags "--share-file=$(path resolve $file)"
            end

            $gsconnect --name=$device_name $file_flags
        end
    end
end

function img
    argparse "f/format=" -- $argv

    if test (count $argv) -eq 0
        set files $fx
    else
        set files $argv
    end

    if set -q _flag_format
        for file in $files
            magick $file (path change-extension .$_flag_format $file)
        end
    end
end

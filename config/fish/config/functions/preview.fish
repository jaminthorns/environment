function preview
    set options $argv

    argparse "width=" "height=" -- $argv

    set path $argv
    set chafa_options --animate=off --polite=on --bg="#282A36"

    set -e options[(contains -i $path $options)]

    if set -q TERM_PROGRAM && test $TERM_PROGRAM = WezTerm && {{os_status wsl && echo false || echo true}}
        set -a chafa_options --format=sixels
    else
        set -a chafa_options --format=symbols --symbols=vhalf
    end

    if set -q _flag_width _flag_height
        set -a chafa_options --view-size={$_flag_width}x{$_flag_height}
    end

    if not test -s $path
        set_color brblack && echo "Empty File" && exit
    end

    switch (file -b --mime-type $path)
        case inode/directory
            eza --all --tree --level=1 --color=always $path
        case application/gzip application/x-7z-compressed application/x-bzip2 application/x-tar application/x-xz application/zip application/zstd
            ouch list --yes --tree $path
        case application/pdf
            pdftoppm -jpeg -f 1 -l 1 $path 2>/dev/null | chafa $chafa_options
        case "image/*"
            chafa $chafa_options $path 2>/dev/null || magick $path tiff:- | chafa $chafa_options
        case "video/*"
            ffmpeg -v quiet -i $path -frames:v 1 -codec:v tiff -f image2pipe - | chafa $chafa_options
        case "*"
            if test (file -b --mime-encoding $path) = binary
                set_color brblack && file --brief --dereference $path | fmt -w $_flag_width
            else
                bat --plain --wrap=character --terminal-width=$_flag_width --color=always $path
            end
    end
end

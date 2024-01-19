function preview
    set options $argv

    argparse "width=" "height=" -- $argv

    set path $argv
    set timg_options --frames=1 -b "#282A36"

    set -e options[(contains -i $path $options)]

    switch $TERM_PROGRAM
        case WezTerm
            set -a timg_options --pixelation=sixel
        case vscode
            # set -a timg_options --pixelation=quarter
            set -a timg_options --pixelation=sixel
    end

    if set -q _flag_width _flag_height
        set -a timg_options -g {$_flag_width}x{$_flag_height}
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
            pdftoppm -jpeg -f 1 -l 1 $path | timg $timg_options
        case "image/*"
            timg $timg_options $path 2>/dev/null || magick $path tiff:- | timg $timg_options
        case "video/*"
            ffmpeg -v quiet -i $path -frames:v 1 -codec:v tiff -f image2pipe - | timg $timg_options
        case "*"
            if test (file -b --mime-encoding $path) = binary
                hexyl --border=none $path
            else
                bat --plain --wrap=character --terminal-width=$_flag_width --color=always $path
            end
    end
end

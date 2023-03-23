function preview
    argparse embedded "width=" "height=" -- $argv

    set path $argv
    set chafa_options --color-extractor=median --bg="#282A36"

    if set -q _flag_embedded
        set -a chafa_options --format=symbols --animate=off
    else
        set -a chafa_options --format=iterm
    end

    if set -q _flag_width _flag_height
        set -a chafa_options --size={$_flag_width}x{$_flag_height}
    end

    switch (file -b --mime-type $path)
        case inode/directory
            exa --all --tree --level=1 $path
        case application/zip
            unzip -l $path
        case application/pdf
            pdftoppm -jpeg -f 1 -l 1 $path | chafa $chafa_options
        case "image/*"
            chafa $chafa_options $path 2>/dev/null || magick $path tiff:- | chafa $chafa_options
        case "video/*"
            ffmpeg -v quiet -i $path -frames:v 1 -codec:v tiff -f image2pipe - | chafa $chafa_options
        case "*"
            bat --plain --color=always $path
    end
end

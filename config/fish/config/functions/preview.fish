function preview
    set options $argv

    argparse no-images "width=" "height=" -- $argv

    set path $argv
    set chafa_options --animate=off --bg="#282A36"

    set -e options[(contains -i $path $options)]

    if set -q _flag_no_images
        set -a chafa_options --format=symbols --color-extractor=median
    else
        set -a chafa_options --format=sixels
    end

    if set -q _flag_width _flag_height
        set -a chafa_options --size={$_flag_width}x{$_flag_height}
    end

    switch (file -b --mime-type $path)
        case inode/directory
            eza --all --tree --level=1 $path
        case application/zip
            zipinfo -1 $path | as-tree --color always
        case application/x-tar
            tar --list --file $path | as-tree --color always
        case application/gzip
            preview $options (gunzip --stdout $path | psub --suffix (path extension $path))
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

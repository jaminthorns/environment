function preview
    argparse "width=" "height=" -- $argv

    set path $argv

    set tiv_options -0

    if set -q _flag_width _flag_height
        set -a tiv_options -w $_flag_width -h $_flag_height
    end

    switch (file -b --mime-type $path)
        case inode/directory
            exa --all --oneline $path
        case application/pdf
            tiv $tiv_options (pdftoppm -f 1 -l 1 $path | psub) 2>/dev/null
        case 'image/*'
            tiv $tiv_options $path 2>/dev/null
        case 'video/*'
            tiv $tiv_options (ffmpeg -v quiet -i $path -frames:v 1 -f image2 - | psub) 2>/dev/null
        case application/json
            bat --style=numbers --color=always $path
        case 'text/*'
            bat --style=numbers --color=always $path
        case '*'
            echo Unsupported file type
            return 1
    end
end

function _git_name_status_color -a pattern color_name
    set color (set_color $color_name)
    set reset (set_color reset)

    echo "s/^($pattern)/$color\1$reset/"
end

function _git_name_status_format
    sed -E \
        -e "s/R[0-9]+/R/" \
        -e "s/\t/ /" \
        -e "s/\t/ ⟶ /" \
        -e (_git_name_status_color A green) \
        -e (_git_name_status_color D red) \
        -e (_git_name_status_color M yellow) \
        -e (_git_name_status_color R magenta)
end

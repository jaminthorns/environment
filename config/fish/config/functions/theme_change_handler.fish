function theme_change_handler --on-variable fish_terminal_color_theme
    set DELTA_FEATURES (string split " " $DELTA_FEATURES)

    switch $fish_terminal_color_theme
        case light
            set -gx BAT_THEME $BAT_THEME_LIGHT

            if set index (contains -i dark-colors $DELTA_FEATURES)
                set -e DELTA_FEATURES[$index]
            end

            if not contains light-colors $DELTA_FEATURES
                set -a DELTA_FEATURES light-colors
            end

        case dark
            set -gx BAT_THEME $BAT_THEME_DARK

            if set index (contains -i light-colors $DELTA_FEATURES)
                set -e DELTA_FEATURES[$index]
            end

            if not contains dark-colors $DELTA_FEATURES
                set -a DELTA_FEATURES dark-colors
            end
    end
end

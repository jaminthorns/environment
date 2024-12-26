function render_prompt
    set_color black
    echo -n ""
    set_color green
    set_color --background black
    echo -n " $argv "
    set_color normal
    set_color black
    echo -n " "
    set_color normal
end

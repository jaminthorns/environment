function lf_vars_split
    if test -z $fs
        set fs
    else
        set fs (string split \n $fs) || true
    end

    if test -z $fx
        set fx
    else
        set fx (string split \n $fx) || true
    end

    set -gx lf_files_selected (count $fs)
    true
end

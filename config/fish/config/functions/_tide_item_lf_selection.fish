function _tide_item_lf_selection
    if set -q lf_files_selected
        if test $lf_files_selected -eq 0
            _tide_print_item lf_selection $tide_lf_selection_icon
        else
            _tide_print_item lf_selection "$tide_lf_selection_icon " $lf_files_selected
        end
    end
end

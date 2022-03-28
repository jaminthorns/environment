function _override_git_alias_completion -a alias command
    set variable __fish_git_alias_$alias

    function _override_git_alias_completion_$alias -V command -V variable -v $variable
        if not test $$variable = $command
            set -g $variable $command
        end
    end
end

_override_git_alias_completion view show
_override_git_alias_completion compare diff
_override_git_alias_completion history log
_override_git_alias_completion stashes stash
_override_git_alias_completion branches branch

# Force enables ANSI colors for dbcli commands

function pgcli --wraps pgcli
    COLORTERM= command pgcli $argv
end

function litecli --wraps litecli
    COLORTERM= command litecli $argv
end

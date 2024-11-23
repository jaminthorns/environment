# Provide functionality for setting a variable in another process.

function parent_pid -a pid
    ps -o ppid= -p $pid | string trim
end

function set_remote -a pid name
    set process_var (__set_remote_process_var $pid)
    set values_var (string join _ $process_var $name)
    set -U -a $process_var $name
    set -U $values_var $argv[3..]
end

function __set_remote_process_var -a pid
    echo _set_remote_$pid
end

function __set_remote_receive -a type event process_var --on-variable (__set_remote_process_var $fish_pid)
    if test $event = SET && set -q $process_var
        for name in $$process_var
            set values_var (string join _ $process_var $name)
            set -g $name $$values_var
            set -U -e $values_var
        end

        set -U -e $process_var
    end
end

set -g send_values_dir /tmp/fish_values
set -g send_values_signal SIGUSR1

function parent_pid -a pid
    ps -o ppid= -p $pid | string trim
end

function send_values -a pid name
    mkdir -p $send_values_dir/$pid
    string collect $argv[3..] >$send_values_dir/$pid/$name
    kill -s $send_values_signal $pid
end

function receive_values --on-signal $send_values_signal
    set process_dir $send_values_dir/$fish_pid

    for filename in $process_dir/*
        set -g (path basename $filename) (cat $filename)
    end

    rm -r $process_dir
end

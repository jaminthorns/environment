current_crontab=$(mktemp)
crontab -l >$current_crontab
merge_config crontab $current_crontab
rm $current_crontab

asdf current | tail -n +2 | tr -s " " | cut -d " " -f 1,2 > config/.tool-versions

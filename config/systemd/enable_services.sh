systemctl --user daemon-reload
systemctl --user enable --now $(ls services)
systemctl --user restart --now $(ls services)

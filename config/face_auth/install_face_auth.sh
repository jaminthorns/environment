if ! cmp --silent has-gnome-session /usr/local/bin/has-gnome-session; then
  sudo install -o root -g root -m 755 has-gnome-session /usr/local/bin/has-gnome-session
fi

if ! grep -q pam_linuxcampam.so /etc/pam.d/gdm-password; then
  sudo tee /etc/pam.d/gdm-password >/dev/null << EOF
auth  [success=ignore default=1]  pam_exec.so quiet /usr/local/bin/has-gnome-session
auth  sufficient                  pam_linuxcampam.so

$(cat /etc/pam.d/gdm-password)
EOF
fi

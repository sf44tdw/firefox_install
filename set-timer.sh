#!/bin/bash

ls -l "flatpak-update.*"
echo
chmod 700 "flatpak-update.*"
echo
ls -l "flatpak-update.*" "/etc/systemd/system/flatpak-update.*"
echo
cp -f "flatpak-update.*" /etc/systemd/system/ || exit 1
echo
ls -l "flatpak-update.*" "/etc/systemd/system/flatpak-update.*"


systemctl daemon-reload || exit 2
systemctl enable flatpak-update.timer || exit 3
systemctl start flatpak-update.timer || exit 4
systemctl status flatpak-update.timer || exit 5
systemctl list-timers | grep 'flatpal-update' || exit 6




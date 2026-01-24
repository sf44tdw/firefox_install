#!/bin/bash

readonly ROOT_HOME='/root'
readonly ROOT_BASH_PROFILE_PATH="${ROOT_HOME}/.bash_profile"
readonly ROOT_PROFILE_PATH="${ROOT_HOME}/.profile"

if [ -f "${ROOT_BASH_PROFILE_PATH}" ]; then
	source "${ROOT_BASH_PROFILE_PATH}" >/dev/null 2>&1 || exit 200
elif [ -f "${ROOT_PROFILE_PATH}" ]; then
	source "${ROOT_PROFILE_PATH}" >/dev/null 2>&1 || exit 210
else
	exit 220
fi

ls -l flatpak-update.*
echo
chmod 700 flatpak-update.*
echo
ls -l flatpak-update.* /etc/systemd/system/flatpak-update.*
echo
cp -f flatpak-update.* /etc/systemd/system/ || exit 1
echo
ls -l flatpak-update.* /etc/systemd/system/flatpak-update.*


systemctl daemon-reload || exit 2
systemctl enable flatpak-update.timer || exit 3
systemctl start flatpak-update.timer || exit 4
systemctl status flatpak-update.timer || exit 5
systemctl list-timers | grep 'flatpal-update' || exit 6

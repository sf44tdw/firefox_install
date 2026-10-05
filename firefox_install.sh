#!/bin/bash
set -euo pipefail

if [ "$(id -u)" -ne 0 ]; then
    echo "This script must be run as root (e.g. with sudo)." >&2
    exit 1
fi

dnf -y install flatpak
echo 'flatpakインストール成功。'
flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo
echo 'flatpakへのflathub登録成功。'
flatpak install -y flathub org.mozilla.firefox
echo 'firefoxインストール成功。'

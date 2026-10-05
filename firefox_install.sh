#!/bin/bash
 
dnf -y install flatpak || exit 1
echo 'flatpakインストール成功。'
flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo || exit 2
echo 'flatpakへのflathub登録成功。'
flatpak install flathub org.mozilla.firefox || exit 3
echo 'firefoxインストール成功。'
exit 0

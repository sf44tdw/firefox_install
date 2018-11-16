#!/bin/bash
 
#このスクリプトの引数にするFirefoxのダウンロード元URLは下記から探す。
#https://download-installer.cdn.mozilla.net/pub/firefox/releases/
 
#(例)Mozilla Firefox 45.2 ESRをインストールする場合は下記のURLを引数に指定する。
#https://download-installer.cdn.mozilla.net/pub/firefox/releases/45.2.0esr/linux-x86_64/ja/firefox-45.2.0esr.tar.bz2
 
#スクリプト実行時に引数が指定されているかを確認。
if [ $# -ne 1 ]; then
  echo "指定された引数は$#個です。" 1>&2
  echo "実行するには1個の引数が必要です。" 1>&2
  exit 1
fi
 
#引数をURLに指定。
URL=${1}
 
#URLからFirefoxのインストーラー名を抽出する。
ARR=( `echo $URL | tr -s '/' ' '`)
CNT=`expr ${#ARR[@]} - 1`
FILE_NAME=${ARR[${CNT}]}
 
#ターゲットとなるFirefoxインストーラー名を表示する。
echo "Target File Name"
echo ${FILE_NAME}
 
#古い(インストール前の)Firefoxのバージョンを表示する。
echo "OLD Firefox Version"
/usr/bin/firefox -V
 
#/opt配下にURLからFirefoxインストーラーをダウンロードする。
cd /opt
curl -O ${URL}
 
#旧バージョンのFirefoxをバックアップしているディレクトリ/opt/firefox_oldを削除する。
rm -rf /opt/firefox_old
 
#現在のバージョンのFirefoxを/opt/firefox_oldに移動する。
mv /opt/firefox /opt/firefox_old
 
#ダウンロードしたFirefoxインストーラーを解凍する。
tar xvf ${FILE_NAME}
 
#新しい(インストール後の)Firefoxのバージョンを表示する。
echo "NEW Firefox Version"
/opt/firefox/firefox -V
 
#Firefoxの現在の実行スクリプトを移動してバックアップする。
mv /usr/bin/firefox /opt/firefox/firefox.old
 
#新バージョンのFirefoxの実行スクリプトのシンボリックリンクを/usr/binに配置する。
ln -s /opt/firefox/firefox /usr/bin/firefox
 
#現在の(実行スクリプト入れ替え後の)Firefoxのバージョンを表示する。
echo "CURRENT Firefox Version"
/usr/bin/firefox -V
 
#インストールに使用したインストーラーを同バージョンの解凍ディレクトリに保管する
cd /opt
mv ${FILE_NAME} /opt/firefox/

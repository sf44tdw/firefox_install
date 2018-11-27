#!/bin/bash
 
#このスクリプトの引数にするThunderbirdのダウンロード元URLは下記から探す。
#https://download-installer.cdn.mozilla.net/pub/thunderbird/releases/
 
#スクリプト実行時に引数が指定されているかを確認。
if [ $# -ne 1 ]; then
  echo "指定された引数は$#個です。" 1>&2
  echo "実行するには1個の引数が必要です。" 1>&2
  exit 1
fi
 
#引数をURLに指定。
URL=${1}
 
#URLからThunderbirdのインストーラー名を抽出する。
ARR=( `echo $URL | tr -s '/' ' '`)
CNT=`expr ${#ARR[@]} - 1`
FILE_NAME=${ARR[${CNT}]}
 
#ターゲットとなるThunderbirdインストーラー名を表示する。
echo "Target File Name"
echo ${FILE_NAME}
 
#古い(インストール前の)Thunderbirdのバージョンを表示する。
echo "OLD Thunderbird Version"
/usr/bin/thunderbird -V
 
#/opt配下にURLからThunderbirdインストーラーをダウンロードする。
cd /opt
curl -O ${URL}
 
#旧バージョンのThunderbirdをバックアップしているディレクトリ/opt/thunderbird_oldを削除する。
rm -rf /opt/thunderbird_old
 
#現在のバージョンのThunderbirdを/opt/thunderbird_oldに移動する。
mv /opt/thunderbird /opt/thunderbird_old
 
#ダウンロードしたThunderbirdインストーラーを解凍する。
tar xvf ${FILE_NAME}
 
#新しい(インストール後の)Thunderbirdのバージョンを表示する。
echo "NEW Thunderbird Version"
/opt/thunderbird/thunderbird -V
 
#Thunderbirdの現在の実行スクリプトを移動してバックアップする。
mv /usr/bin/thunderbird /opt/thunderbird/thunderbird.old
 
#新バージョンのThunderbirdの実行スクリプトのシンボリックリンクを/usr/binに配置する。
ln -s /opt/thunderbird/thunderbird /usr/bin/thunderbird
 
#現在の(実行スクリプト入れ替え後の)Thunderbirdのバージョンを表示する。
echo "CURRENT Thunderbird Version"
/usr/bin/thunderbird -V
 
#インストールに使用したインストーラーを同バージョンの解凍ディレクトリに保管する
cd /opt
mv ${FILE_NAME} /opt/thunderbird/

#!/bin/sh

PATH_BASE_CLIENT_DEST=$1
PATH_BASE_SRV_DEST=$2

PATH_BASE_CLIENT_SRC=$3
PATH_BASE_SRV_SRC=$4


FILE_CLIENT_1=`diff -qr $PATH_BASE_CLIENT_DEST $PATH_BASE_CLIENT_SRC | grep 'Seulement'| grep -v '.git\|out\|.env\|node_modules\|coverage\|directives\|dist' | awk '{print $3 $4}' | sed 's/:/\//' | awk -F"client/" '{print $2}'` 
FILE_CLIENT_2=`diff -qr $PATH_BASE_CLIENT_DEST $PATH_BASE_CLIENT_SRC | grep 'différents' | awk '{print $5}' | awk -F"client/" '{print $2}'`

FILE_SRV_1=`diff -qr $PATH_BASE_SRV_DEST $PATH_BASE_SRV_SRC | grep 'Seulement'| grep -v '.git\|out\|.env\|node_modules' | awk '{print $3 $4}' | sed 's/:/\//' | awk -F"server/" '{print $2}'` 
FILE_SRV_2=`diff -qr $PATH_BASE_SRV_DEST $PATH_BASE_SRV_SRC | grep 'différents' | awk '{print $5}' | awk -F"server/" '{print $2}'`

for FILE_CLIENT in $FILE_CLIENT_1 $FILE_CLIENT_2
do
    DIR_CLIENT=`dirname $FILE_CLIENT`
    mkdir -p $PATH_BASE_CLIENT_DEST/$DIR_CLIENT
    cp -rp $PATH_BASE_CLIENT_SRC/$FILE_CLIENT $PATH_BASE_CLIENT_DEST/$FILE_CLIENT
done

for FILE_SRV in $FILE_SRV_1 $FILE_SRV_2
do
    DIR_SRV=`dirname $FILE_SRV`
    mkdir -p $PATH_BASE_SRV_DEST/$DIR_SRV
    cp -rp $PATH_BASE_SRV_SRC/$FILE_SRV $PATH_BASE_SRV_DEST/$FILE_SRV
done

echo "Tout va bien!!"

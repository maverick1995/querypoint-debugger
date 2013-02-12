#!/bin/bash 

if [ $# -ne 2 ]
then
    echo "usage: relase.sh <pem key> <user>"
    exit 1
fi


QUERYPOINTDIR="../"
PEMKEY=$1
CRXPREFIX='QuerypointDebugger'
USER=$2

read -s -p "Enter password: " PASS

read -d '' DESCRIPTION << "EOF"
Installation instructions:
http://google.github.com/qpp/test/LayoutTests/DocGen/demoSetup.html
EOF

v=`cat version`
s=`echo "$v 1" | awk '{printf "%d",$1+$2}'`
echo "$s" > version

CRXFILE=${CRXPREFIX}"_0_"${s}".crx"
echo $CRXFILE
s=0.$s

cd $QUERYPOINTDIR
yes | rm -r build/ extension/
sh install.sh
replace='s/\"version\".*/\"version\": \"'"$s"'\",/'
sed -i "$replace" extension/manifest.json

cd -
sh ./build/crxmake.sh $QUERYPOINTDIR/extension/ $PEMKEY $CRXFILE

./googlecode_upload.py -p querypoint-debugger -u $USER -w $PASS -s "Querypoint Debugger v$s" -d "$DESCRIPTION" $CRXFILE

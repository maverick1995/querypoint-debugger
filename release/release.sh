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
Sorry Chrome want to discourage installation outside of Chrome WebStore:
1) Use chrome://flags
   enable Experimental Extension APIs
   relaunch chrome
2) Download .crx. 
   ignore the error message
   Open chrome://downloads/#
   Click on "Open downloads folder"
   Open chrome://extensions
   Drag the .crx file on to the chrome://extensions
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

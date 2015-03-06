#!/bin/sh
CURDIR=$(pwd)
CINNAMONDIR=$HOME"/.local/share/cinnamon/"
echo CINNAMONDIR $CINNAMONDIR
APPLETDIR=$CINNAMONDIR"applets/"
echo APPLETDIR $APPLETDIR
ICONDIR="/usr/share/pixmaps/"
echo ICONDIR $ICONDIR

PAUSEDIR="mpd-pause-play@cinnamon.org"
NEXTDIR="mpd-next@cinnmon.org"
PREVDIR="mpd-prev@cinnamon.org"
STATUSDIR="nmpd-status@cinnamon.org"



echo "By default this scrips installs the newest version of mpd-control"
if [ -d "$CINNAMONDIR" ]; then
	if [ ! -d "$APPLETDIR" ]; then
		mkdir $APPLETDIR 
	fi
	echo "cp -r ./$NEXTDIR/ $APPLETDIR"
#	cp -r ./$NEXTDIR/ $APPLETDIR
	echo "cp -r ./$PREVDIR/ $APPLETDIR"
#	cp -r ./$PREVDIR/ $APPLETDIR
	echo "cp -r ./$STATUSDIR/ $APPLETDIR"
#	cp -r ./$STATUSDIR/ $APPLETDIR
	echo "cp -r ./$PAUSEDIR/ $APPLETDIR"
#	cp -r ./$PAUSEDIR/ $APPLETDIR
	echo "cp ./mpd-control-icons/* $ICONDIR"
#	cp ./mpd-control-icons/* $ICONDIR
else
	echo "cinnamon needs to be installed"
	exit 1
fi

#MD5 check
#find ./ -not -name hashsum -type f -exec md5sum {} \; | sort -k 34 

exit 0

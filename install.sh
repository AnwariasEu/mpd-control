#!/bin/sh
CURDIR=$(pwd)
CINNAMONDIR=$HOME"/.local/share/cinnamon/"
echo CINNAMONDIR $CINNAMONDIR
APPLETDIR=$CINNAMONDIR"applets/"
echo APPLETDIR $APPLETDIR

PAUSEDIR="mpd-pause-play@cinnamon.org"
NEXTDIR="mpd-next@cinnamon.org"
PREVDIR="mpd-previous@cinnamon.org"
STATUSDIR="mpd-status@cinnamon.org"

#MD5 check
md5sum -c checklist.chk
if [ $? -ne 0 ];then
	echo "md5sum missmatch installation stopped"
	exit 1
fi

echo "By default this scrips installs the newest version of mpd-control into the users directory."
if [ -d "$CINNAMONDIR" ]; then
	if [ ! -d "$APPLETDIR" ]; then
		mkdir $APPLETDIR 
	fi
	echo "cp -r ./$NEXTDIR/ $APPLETDIR"
	cp -r ./$NEXTDIR/ $APPLETDIR
	echo "cp -r ./$PREVDIR/ $APPLETDIR"
	cp -r ./$PREVDIR/ $APPLETDIR
	echo "cp -r ./$STATUSDIR/ $APPLETDIR"
	cp -r ./$STATUSDIR/ $APPLETDIR
	echo "cp -r ./$PAUSEDIR/ $APPLETDIR"
	cp -r ./$PAUSEDIR/ $APPLETDIR
else
	echo "cinnamon needs to be installed"
	exit 1
fi

echo -e "Installation successful.\nTo uninstall remove $APPLETDIR{$PAUSEDIR,$NEXTDIR,$PREVDIR$,$STATUSDIR}"
exit 0

#!/bin/sh

INPUTVIDEO="$1"  # Full path to recording, i.e. /home/user/Videos/News.ts

BASENAME=`/usr/bin/basename $INPUTVIDEO .mkv`

DIRNAME=`/usr/bin/dirname $INPUTVIDEO`
EDLFILE="$DIRNAME/$BASENAME.edl"
LOGFILE="$DIRNAME/$BASENAME.log"
TXTFILE="$DIRNAME/$BASENAME.txt"
LOGOFILE="$DIRNAME/$BASENAME.logo.txt"
COMSKIPPATH="/volume1/@appstore/tvheadend-testing/bin/comskip"
COMSKIPINI="/volume1/@appstore/tvheadend-testing/var/comskip.ini"
COMSKIPLOGS="/volume1/@appstore/tvheadend-testing/var/comskip.log"
TVHEADENDPP="/volume1/@appstore/tvheadend-testing/var/tvheadend-pp.log"

CreateLog(){
    echo "***** CREATE LOG *****" >> ${TVHEADENDPP}/tvheadendpp$$.log
    echo "*****" > ${TVHEADENDPP}/tvheadendpp$$.log
    echo "***** INPUT = $INPUTVIDEO *****" >> ${TVHEADENDPP}/tvheadendpp$$.log
    echo "*****" >> ${TVHEADENDPP}/tvheadendpp$$.log
}

FlagCommercials(){
    echo "Starting Commercial Flagging" >> ${TVHEADENDPP}/tvheadendpp$$.log
    echo "*****" >> ${TVHEADENDPP}/tvheadendpp$$.log
    echo "***** OUTPUT = "$EDLFILE" *****" >> ${TVHEADENDPP}/tvheadendpp$$.log
    echo "*****" >> ${TVHEADENDPP}/tvheadendpp$$.log
    /usr/bin/whoami >> ${TVHEADENDPP}/tvheadendpp$$.log    # for debugging purposes, who is running this script?
    echo "Started at `/bin/date`" >> ${TVHEADENDPP}/tvheadendpp$$.log
    echo "*****" >> ${TVHEADENDPP}/tvheadendpp$$.log
    echo "*****" >> ${TVHEADENDPP}/tvheadendpp$$.log

    $COMSKIPPATH --ini=$COMSKIPINI $INPUTVIDEO 2>&1 </dev/null >> ${TVHEADENDPP}/tvheadendpp$$.log

    echo "*****" >> ${TVHEADENDPP}/tvheadendpp$$.log
    echo "*****" >> ${TVHEADENDPP}/tvheadendpp$$.log

    echo "EDL for $INPUTVIDEO:" >> ${TVHEADENDPP}/tvheadendpp$$.log
}

CleanUp(){
    echo "***** CLEAN UP *****" >> ${TVHEADENDPP}/tvheadendpp$$.log
    echo "[[ ! -f $LOGFILE ]] || /bin/mv $LOGFILE $COMSKIPLOGS"
    echo "[[ ! -f $TXTFILE ]] || /bin/mv $TXTFILE $COMSKIPLOGS"
    /bin/mv $LOGFILE $COMSKIPLOGS
    /bin/mv $TXTFILE $COMSKIPLOGS
}	

CreateLog
FlagCommercials
CleanUp

echo "Finished at `/bin/date`" >> ${TVHEADENDPP}/tvheadendpp$$.log

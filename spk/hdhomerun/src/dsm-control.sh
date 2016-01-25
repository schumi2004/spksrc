#!/bin/sh

# Package
PACKAGE="hdhomerun"

# Others
INSTALL_DIR="/usr/local/${PACKAGE}"
FFMPEG_TARGET="/usr/bin/${PACKAGE}"
FFSERVER_TARGET="/usr/bin/ffserver"
LOG_FILE="/var/log/dvbhdhomerun_libhdhomerun.log"

start_daemon ()
{
    mkdir -p /dev/dvb/adapter0
    mknod /dev/dvb/adapter0/demux0 c 212 4
    mknod /dev/dvb/adapter0/dvr0 c 212 5
    mknod /dev/dvb/adapter0/frontend0 c 212 3
    mknod /dev/dvb/adapter0/net0 c 212 7
    mkdir -p /dev/dvb/adapter1
    mknod /dev/dvb/adapter1/demux0 c 212 68
    mknod /dev/dvb/adapter1/dvr0 c 212 69
    mknod /dev/dvb/adapter1/frontend0 c 212 67
    mknod /dev/dvb/adapter1/net0 c 212 71
    mkdir -p /dev/dvb/adapter2
    mknod /dev/dvb/adapter2/demux0 c 212 132
    mknod /dev/dvb/adapter2/dvr0 c 212 133
    mknod /dev/dvb/adapter2/frontend0 c 212 131
    mknod /dev/dvb/adapter2/net0 c 212 135
    mkdir -p /dev/dvb/adapter3
    mknod /dev/dvb/adapter3/demux0 c 212 196
    mknod /dev/dvb/adapter3/dvr0 c 212 197
    mknod /dev/dvb/adapter3/frontend0 c 212 195
    mknod /dev/dvb/adapter3/net0 c 212 199
    mkdir -p /dev/dvb/adapter4
    mknod /dev/dvb/adapter4/demux0 c 212 260
    mknod /dev/dvb/adapter4/dvr0 c 212 261
    mknod /dev/dvb/adapter4/frontend0 c 212 259
    mknod /dev/dvb/adapter4/net0 c 212 263
    mkdir -p /dev/dvb/adapter5
    mknod /dev/dvb/adapter5/demux0 c 212 324
    mknod /dev/dvb/adapter5/dvr0 c 212 325
    mknod /dev/dvb/adapter5/frontend0 c 212 323
    mknod /dev/dvb/adapter5/net0 c 212 327
    mkdir -p /dev/dvb/adapter6
    mknod /dev/dvb/adapter6/demux0 c 212 388
    mknod /dev/dvb/adapter6/dvr0 c 212 389
    mknod /dev/dvb/adapter6/frontend0 c 212 387
    mknod /dev/dvb/adapter6/net0 c 212 391
    mkdir -p /dev/dvb/adapter7
    mknod /dev/dvb/adapter7/demux0 c 212 452
    mknod /dev/dvb/adapter7/dvr0 c 212 453
    mknod /dev/dvb/adapter7/frontend0 c 212 451
    mknod /dev/dvb/adapter7/net0 c 212 455

    chmod 755 /dev/dvb/adapter*
    chmod 666 /dev/dvb/adapter*/*
    chown root:root /dev/dvb/adapter*/*

    insmod ${INSTALL_DIR}/bin/dvb-core.ko
    insmod ${INSTALL_DIR}/bin/dvb_hdhomerun_core.ko
    insmod ${INSTALL_DIR}/bin/dvb_hdhomerun_fe.ko
    insmod ${INSTALL_DIR}/bin/dvb_hdhomerun.ko

    DYNAMIC_ID=$(grep hdhomerun_control /proc/misc | awk "{print \$1}")
    if [ "$DYNAMIC_ID" != "" ]; then
        echo "making node hdhomerun_control" $DYNAMIC_ID
        mknod /dev/hdhomerun_control c 10 $DYNAMIC_ID
    else
        echo "Unable to detect hdhomerun_control inside /proc/misc."
    fi
    chmod 666 /dev/hdhomerun_control
    chown root:root /dev/hdhomerun_control

    export LD_LIBRARY_PATH=/usr/lib

    /usr/bin/userhdhomerun -f -d

    sleep 1

    DYNAMIC_ID=$(grep hdhomerun_data /proc/devices | awk "{print \$1}")
    if [ "$DYNAMIC_ID" != "" ]; then
        echo "making node hdhomerun_data" $DYNAMIC_ID
        mknod /dev/hdhomerun_data0 c $DYNAMIC_ID 0
        mknod /dev/hdhomerun_data1 c $DYNAMIC_ID 1
        mknod /dev/hdhomerun_data2 c $DYNAMIC_ID 2
        mknod /dev/hdhomerun_data3 c $DYNAMIC_ID 3
        mknod /dev/hdhomerun_data3 c $DYNAMIC_ID 4
        mknod /dev/hdhomerun_data3 c $DYNAMIC_ID 5
        mknod /dev/hdhomerun_data3 c $DYNAMIC_ID 6
        mknod /dev/hdhomerun_data3 c $DYNAMIC_ID 7
    else
        echo "Unable to detect hdhomerun_data inside /proc/devices."
    fi

    chmod 666 /dev/hdhomerun_data*
    chown root:root /dev/hdhomerun_data*
}

stop_daemon ()
{
    if [ -e /var/packages/tvheadend/scripts/start-stop-status ]; then
        /var/packages/tvheadend/scripts/start-stop-status stop
    fi

    if [ -e /var/packages/tvheadend-testing/scripts/start-stop-status ]; then
        /var/packages/tvheadend-testing/scripts/start-stop-status stop
    fi

    killall userhdhomerun

    sleep 1

    killall -9 userhdhomerun

    sleep 1

    rmmod ${INSTALL_DIR}/bin/dvb_hdhomerun.ko
    rmmod ${INSTALL_DIR}/bin/dvb_hdhomerun_fe.ko
    rmmod ${INSTALL_DIR}/bin/dvb_hdhomerun_core.ko
    rmmod ${INSTALL_DIR}/bin/dvb-core.ko

    rm -rf /dev/hdhomerun_*
    rm -rf /dev/dvb/*
}

daemon_status ()
{
    STATUS=$(ps | grep userhdhomerun | wc -l)
    if [ "$STATUS" -ne 1 ]; then
        return 0
    else
        return 1
    fi
}

case $1 in
    start)
        if daemon_status; then
            echo ${DNAME} is already running
            exit 0
        else
             echo Starting ${DNAME} ...
             start_daemon
             exit $?
        fi
        ;;
    stop)
        if daemon_status; then
            echo Stopping ${DNAME} ...
            stop_daemon
            exit $?
        else
            echo ${DNAME} is not running
            exit 0
        fi
        ;;
    restart)
        stop_daemon
        start_daemon
        ;;
    status)
        if daemon_status; then
            echo ${DNAME} is running
            exit 0
        else
            echo ${DNAME} is not running
            exit 1
        fi
        ;;
    log)
        echo ${LOG_FILE}
        ;;
    *)
        exit 1
        ;;
esac

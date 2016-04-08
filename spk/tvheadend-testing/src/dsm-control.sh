#!/bin/sh

# Package
PACKAGE="tvheadend-testing"
DNAME="Tvheadend-testing"

# Others
INSTALL_DIR="/usr/local/${PACKAGE}"
PATH="${INSTALL_DIR}/bin:/usr/local/bin:/bin:/usr/bin:/usr/syno/bin"
USER="tvheadend-testing"
TVHEADEND="${INSTALL_DIR}/bin/tvheadend"
PID_FILE="${INSTALL_DIR}/var/tvheadend.pid"
LOG_FILE="${INSTALL_DIR}/var/tvheadend.log"

if [ -e /usr/local/sundtek/opt/lib/libmediaclient.so ]; then
    export LD_PRELOAD=/usr/local/sundtek/opt/lib/libmediaclient.so
fi

start_daemon ()
{
    ${TVHEADEND} -f -u ${USER} -c ${INSTALL_DIR}/var -p ${PID_FILE} -l ${LOG_FILE} --debug "" -S
}

stop_daemon ()
{
    ps -eo pid,cmd | grep "${TVHEADEND}" | awk '{print $1}' | xargs kill
    sleep 2
    ps -eo pid,cmd | grep "${TVHEADEND}" | awk '{print $1}' | xargs kill -9
    rm -f ${PID_FILE}
}

stop_all ()
{
    stop_daemon
}

daemon_status ()
{
    if [ -f ${PID_FILE} ] && [ -d /proc/`cat ${PID_FILE}` ]; then
        return
    fi
    return 1
}

wait_for_status ()
{
    counter=$2
    while [ ${counter} -gt 0 ]; do
        daemon_status
        [ $? -eq $1 ] && break
        let counter=counter-1
        sleep 1
    done
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
    stopall)
        if daemon_status; then
            echo Stopping ${DNAME} ...
            stop_all
            exit $?
        else
            echo ${DNAME} is not running
            exit 0
        fi
        ;;
    restart)
        stop_daemon
        start_daemon
        exit $?
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

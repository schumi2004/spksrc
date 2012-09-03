#!/bin/sh

# Package
PACKAGE="htpcmanager"
DNAME="HTPCManager"

# Others
INSTALL_DIR="/usr/local/${PACKAGE}"
PYTHON_DIR="/usr/local/python"
PATH="${INSTALL_DIR}/bin:${INSTALL_DIR}/env/bin:${PYTHON_DIR}/bin:/usr/local/bin:/bin:/usr/bin:/usr/syno/bin"
RUNAS="htpcmanager"
PYTHON="${INSTALL_DIR}/env/bin/python"
HTPCMANAGER="${INSTALL_DIR}/share/HTPCManager/Htpc.py"
CFG_FILE="${INSTALL_DIR}/var/config.cfg"
PID_FILE="${INSTALL_DIR}/var/htpcmanager.pid"
LOG_FILE="${INSTALL_DIR}/var/logs/HTPCManager.log"


start_daemon()
{
    su - ${RUNAS} -c "PATH=${PATH} ${PYTHON} ${HTPCMANAGER} --daemon --pid ${PID_FILE} --config ${CFG_FILE} --datadir ${INSTALL_DIR}/var/"
}

stop_daemon()
{
    kill `cat ${PID_FILE}`
    wait_for_status 1 20
    rm -f ${PID_FILE}
}

daemon_status()
{
    if [ -f ${PID_FILE} ] && [ -d /proc/`cat ${PID_FILE}` ]; then
        return 0
    fi
    return 1
}

wait_for_status()
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
        else
            echo Starting ${DNAME} ...
            start_daemon
        fi
        ;;
    stop)
        if daemon_status; then
            echo Stopping ${DNAME} ...
            stop_daemon
        else
            echo ${DNAME} is not running
        fi
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


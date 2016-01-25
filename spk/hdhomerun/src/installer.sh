#!/bin/sh

# Package
PACKAGE="hdhomerun"

HDHOMERUN_TARGET_DIR="/usr/bin"
LIBRARY_TARGET_DIR="/usr/lib"
CONFIG_TARGET_DIR="/etc"

# Others
INSTALL_DIR="/usr/local/${PACKAGE}"
SSS="/var/packages/${PACKAGE}/scripts/start-stop-status"
TUNER_TYPE="DVB-T"


preinst ()
{
    exit 0
}

postinst ()
{
    ln -s ${SYNOPKG_PKGDEST} ${INSTALL_DIR}

    ln -s ${INSTALL_DIR}/bin/hdhomerun_config ${HDHOMERUN_TARGET_DIR}
    ln -s ${INSTALL_DIR}/bin/userhdhomerun ${HDHOMERUN_TARGET_DIR}

    ln -s ${INSTALL_DIR}/lib/libhdhomerun.so ${LIBRARY_TARGET_DIR}

    if [ ${wizard_hdhomerun_dvbc} == "true" ]; then
        TUNER_TYPE="DVB-C"
    else
        if [ ${wizard_hdhomerun_atsc} == "true" ]; then
            TUNER_TYPE="ATSC"
        fi
    fi

    mkdir -p ${INSTALL_DIR}/etc
    touch ${INSTALL_DIR}/etc/dvbhdhomerun

    TUNERS=`${INSTALL_DIR}/bin/hdhomerun_config discover | awk '{print $3 " "}'`

    for TUNER in ${TUNERS}
    do
        INDEX=0
        while [ ${INDEX} -lt 12 ]; do
            STATUS=`${INSTALL_DIR}/bin/hdhomerun_config ${TUNER} get /tuner${INDEX}/status`
            if echo "${STATUS}" | grep -q "ERROR"
            then
                break
            fi
            printf "[${TUNER}-${INDEX}]\ntuner_type=${TUNER_TYPE}\nuse_full_name=true\n\n" >> ${INSTALL_DIR}/etc/dvbhdhomerun
            let INDEX=INDEX+1
        done
    done

    printf "[libhdhomerun]\nenable=true\nlogfile=/var/log/dvbhdhomerun_libhdhomerun.log" >> ${INSTALL_DIR}/etc/dvbhdhomerun

    ln -s ${INSTALL_DIR}/etc/dvbhdhomerun ${CONFIG_TARGET_DIR}

    exit 0
}

preuninst ()
{
    ${SSS} stop > /dev/null

    rm -f ${HDHOMERUN_TARGET_DIR}/hdhomerun_config
    rm -f ${HDHOMERUN_TARGET_DIR}/userhdhomerun
    rm -f ${LIBRARY_TARGET_DIR}/libhdhomerun.so
    rm -f ${CONFIG_TARGET_DIR}/dvbhdhomerun

    exit 0
}

postuninst ()
{
    # Remove link
    rm -f ${INSTALL_DIR}

    exit 0
}

preupgrade ()
{
    exit 0
}

postupgrade ()
{
    exit 0
}


#!/bin/sh

# Package
PACKAGE="tvheadend-testing"
DNAME="Tvheadend-Testing"

# Others
INSTALL_DIR="/usr/local/${PACKAGE}"
SSS="/var/packages/${PACKAGE}/scripts/start-stop-status"
PATH="${INSTALL_DIR}/bin:/usr/local/bin:/bin:/usr/bin:/usr/syno/bin:/usr/syno/sbin"
USER="tvheadend-testing"
GROUP="users"
PASS=`openssl rand -base64 32`
TMP_DIR="${SYNOPKG_PKGDEST}/../../@tmp"

SERVICETOOL="/usr/syno/bin/servicetool"
FWPORTS="/var/packages/${PACKAGE}/scripts/${PACKAGE}.sc"

preinst ()
{
    exit 0
}

postinst ()
{
    # Link
    ln -s ${SYNOPKG_PKGDEST} ${INSTALL_DIR}

    # Install busybox stuff
    ${INSTALL_DIR}/bin/busybox --install ${INSTALL_DIR}/bin

    # Create user
    VERSION=`uname -a | awk '{ print $4 }' | sed 's/#//g'`
    if [ $VERSION -gt 5565 ]; then
        synouser --add "${USER}" "${PASS}" "${DNAME} User" 0 "" 0
    else
        adduser -h ${INSTALL_DIR}/var -g "${DNAME} User" -G ${GROUP} -s /bin/sh -S -D ${USER}  
    fi

    wizard_password=`echo -n "TVHeadend-Hide-${wizard_password:=admin}" | openssl enc -a`

    # Edit the configuration according to the wizard
    sed -i -e "s/@username@/${wizard_username:=admin}/g" ${INSTALL_DIR}/var/accesscontrol/51e0c4a6998964ef8e8d85b3ea6107ce

    sed -i -e "s/@username@/${wizard_username:=admin}/g" ${INSTALL_DIR}/var/passwd/34126fd463ea05e47b08c666abc74a3f
    sed -i -e "s/@password@/${wizard_password}/g" ${INSTALL_DIR}/var/passwd/34126fd463ea05e47b08c666abc74a3f

    # Correct the files ownership
    chown -R ${USER}:users ${SYNOPKG_PKGDEST}

    chown -R ${USER}:users ${INSTALL_DIR}/var/accesscontrol/*
    chmod 700 ${INSTALL_DIR}/var/accesscontrol/*

    chown -R ${USER}:users ${INSTALL_DIR}/var/passwd/*
    chmod 700 ${INSTALL_DIR}/var/passwd/*

    # Add firewall config
    ${SERVICETOOL} --install-configure-file --package ${FWPORTS} >> /dev/null

    exit 0
}

preuninst ()
{
    # Stop the package
    ${SSS} stop > /dev/null

    # Remove the user (if not upgrading)
    if [ "${SYNOPKG_PKG_STATUS}" != "UPGRADE" ]; then
        synouser --del ${USER}
    fi

    # Remove firewall config
    if [ "${SYNOPKG_PKG_STATUS}" == "UNINSTALL" ]; then
        ${SERVICETOOL} --remove-configure-file --package ${PACKAGE}.sc >> /dev/null
    fi

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
    # Stop the package
    ${SSS} stop > /dev/null

    # Remove Existing logfile
    rm -f ${INSTALL_DIR}/var/tvheadend.log

    # Save some stuff
    rm -fr ${TMP_DIR}/${PACKAGE}
    mkdir -p ${TMP_DIR}/${PACKAGE}
    mv ${INSTALL_DIR}/var ${TMP_DIR}/${PACKAGE}/

    exit 0
}

postupgrade ()
{
    # Restore some stuff
    rm -fr ${INSTALL_DIR}/var
    mv ${TMP_DIR}/${PACKAGE}/var ${INSTALL_DIR}/
    rm -fr ${TMP_DIR}/${PACKAGE}

    # Disable Digest Auth
    sed -i 's/"digest": true/"digest": false/g' ${INSTALL_DIR}/var/config

    exit 0
}

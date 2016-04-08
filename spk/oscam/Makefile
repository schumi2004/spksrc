SPK_NAME = oscam
SPK_VERS = 1.20-r11225
SPK_REV = 1
SPK_ICON = src/oscam.png
DSM_UI_DIR = app

DEPENDS = cross/busybox cross/$(SPK_NAME)

MAINTAINER = schumi2004
DESCRIPTION = OSCam is a multi-protocol and cross-platform card server. A card server is a software which acts as a key host for card clients. A card server usually has one or more smartcard readers and ethernet interface. It emulates conditional access module \(CAM\) for accessing smartcard and offers virtual common interface to the clients. OSCam has a card client and a web interface
ADMIN_PORT = 19080
RELOAD_UI = yes
DISPLAY_NAME = OSCam
CHANGELOG = "Updated to revision 1.20-r11225"

HOMEPAGE = https://www.oscam.to/
LICENSE  =

INSTALLER_SCRIPT = src/installer.sh
SSS_SCRIPT       = src/dsm-control.sh
FWPORTS          = src/${SPK_NAME}.sc

INSTALL_PREFIX = /usr/local/$(SPK_NAME)

POST_STRIP_TARGET = oscam_extra_install

BUSYBOX_CONFIG = usermng_pidof_defconfig
ENV += BUSYBOX_CONFIG="$(BUSYBOX_CONFIG)"

include ../../mk/spksrc.spk.mk

.PHONY: oscam_extra_install
oscam_extra_install:
	install -m 755 -d $(STAGING_DIR)/var
	install -m 755 -d $(STAGING_DIR)/var/tpl
	wget http://www.streamboard.tv/oscam-addons/export/HEAD/oscam-template/Envi_template/branches/compressed_files/Envi_Template.zip
	unzip Envi_Template.zip -d $(STAGING_DIR)/var/tpl
	install -m 755 -d $(STAGING_DIR)/app
	install -m 644 src/oscam.conf $(STAGING_DIR)/var/oscam.conf
	install -m 644 src/app/config $(STAGING_DIR)/app/config
	install -m 755 src/app/oscam.cgi.pl $(STAGING_DIR)/app/oscam.cgi
	install -m 755 -d $(STAGING_DIR)/app/images
	for size in 16 24 32 48 72 ; \
	do \
	    convert $(SPK_ICON) -thumbnail $${size}x$${size} \
	            $(STAGING_DIR)/app/images/$(SPK_NAME)-$${size}.png ; \
	done

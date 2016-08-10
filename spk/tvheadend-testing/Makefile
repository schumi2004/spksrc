SPK_NAME = tvheadend-testing
SPK_VERS = 4.1.2132
SPK_REV = 1
SPK_ICON = src/tvheadend-testing.png
DSM_UI_DIR = app

DEPENDS = cross/busybox cross/$(SPK_NAME)

MAINTAINER = SynoCommunity
DESCRIPTION = Tvheadend is a TV streaming server for Linux supporting DVB-S, DVB-S2, DVB-C, DVB-T, ATSC, IPTV and Analog video \(V4L\) as input sources. It also comes with a powerful and easy to use web interface both used for configuration and day-to-day operations, such as searching the EPG and scheduling recordings. Even so, the most notable feature of Tvheadend is how easy it is to set up: Install it, navigate to the web user interface, drill into the TV adapters tab, select your current location and Tvheadend will start scanning channels and present them to you in just a few minutes
ADMIN_PORT = 9981
RELOAD_UI = yes
DISPLAY_NAME = Tvheadend-Testing
CHANGELOG = "Update to 4.1.2132"

HOMEPAGE = https://www.lonelycoder.com/tvheadend/
LICENSE  =

WIZARDS_DIR = src/wizard/

INSTALLER_SCRIPT   = src/installer.sh
SSS_SCRIPT         = src/dsm-control.sh
FWPORTS            = src/${SPK_NAME}.sc
ADDITIONAL_SCRIPTS =

INSTALL_PREFIX = /usr/local/$(SPK_NAME)

POST_STRIP_TARGET = tvheadend_extra_install

BUSYBOX_CONFIG = usrmng
ENV += BUSYBOX_CONFIG="$(BUSYBOX_CONFIG)"

include ../../mk/spksrc.spk.mk

.PHONY: tvheadend_extra_install
tvheadend_extra_install:
	install -m 755 -d $(STAGING_DIR)/var
	install -m 755 -d $(STAGING_DIR)/app
	install -m 644 src/app/config $(STAGING_DIR)/app/config
	install -m 755 src/app/tvheadend.cgi.pl $(STAGING_DIR)/app/tvheadend.cgi
	install -m 755 -d $(STAGING_DIR)/var/accesscontrol
	install -m 700 src/accesscontrol.json $(STAGING_DIR)/var/accesscontrol/51e0c4a6998964ef8e8d85b3ea6107ce
	install -m 755 -d $(STAGING_DIR)/var/passwd
	install -m 700 src/passwd.json $(STAGING_DIR)/var/passwd/34126fd463ea05e47b08c666abc74a3f
	install -m 644 src/comskip.ini $(STAGING_DIR)/var/comskip.ini
	install -m 644 src/comskip.dictionary $(STAGING_DIR)/var/comskip.dictionary
	install -m 755 src/tvheadend-pp.sh $(STAGING_DIR)/var/tvheadend-pp.sh
	install -m 755 -d $(STAGING_DIR)/app/images
	for size in 16 24 32 48 72 ; \
	do \
	    convert $(SPK_ICON) -thumbnail $${size}x$${size} \
	            $(STAGING_DIR)/app/images/$(SPK_NAME)-$${size}.png ; \
	done

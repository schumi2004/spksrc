SPK_NAME = htpcmanager
SPK_VERS = $(shell date +%Y%m%d)
SPK_REV = 1
SPK_ICON = src/htpcmanager.png
DSM_UI_DIR = app

DEPENDS  =
SPK_DEPENDS = "python>=2.7.3-1"

MAINTAINER = SynoCommunity
DESCRIPTION = HTPCManager
ADMIN_PORT = 8200
RELOAD_UI = yes
DISPLAY_NAME = HTPCManager

HOMEPAGE   = http://htpcmanager.org/
LICENSE    = GPL

INSTALLER_SCRIPT = src/installer.sh
SSS_SCRIPT       = src/dsm-control.sh

INSTALL_PREFIX = /usr/local/$(SPK_NAME)

COPY_TARGET = nop
POST_STRIP_TARGET = htpcmanager_extra_install

# Pure Python package, make sure ARCH is not defined
override ARCH=

include ../../mk/spksrc.spk.mk

.PHONY: htpcmanager_extra_install
htpcmanager_extra_install: $(STAGING_DIR)/share/HTPCManager
	install -m 755 -d $(STAGING_DIR)/var
	install -m 600 src/config.cfg $(STAGING_DIR)/var/config.cfg
	install -m 755 -d $(STAGING_DIR)/app
	install -m 644 src/app/config $(STAGING_DIR)/app/config
	install -m 755 src/app/htpcmanager.cgi.py $(STAGING_DIR)/app/htpcmanager.cgi
	install -m 755 -d $(STAGING_DIR)/app/images
	for size in 16 24 32 48; do \
		convert $(SPK_ICON) -thumbnail $${size}x$${size} \
		        $(STAGING_DIR)/app/images/$(SPK_NAME)-$${size}.png ; \
	done

$(STAGING_DIR)/share/HTPCManager:
	install -m 755 -d $(STAGING_DIR)/share
	cd $(STAGING_DIR)/share && git clone https://github.com/mbw2001/HTPC-Manager.git HTPCManager
	rm -fr $(STAGING_DIR)/share/HTPCManager/.git $(STAGING_DIR)/share/HTPCManager/.gitignore


SPK_NAME = hdhomerun
SPK_VERS = 1.0.1
SPK_REV = 1
SPK_ICON = src/hdhomerun.png
FIRMWARE = 5.0-4458

DEPENDS = cross/$(SPK_NAME)

WIZARDS_DIR = src/wizard/

MAINTAINER = Dierkse
DESCRIPTION = Driver to use SiliconDust HDHomeRun DVB-T DVB-C ATSC tuners with Synology Diskstations. Supports up to 8 tuners.
DISPLAY_NAME = HDHomerun
CHANGELOG = ""

HOMEPAGE = http://www.hdhomerun.net
LICENSE  =

INSTALLER_SCRIPT = src/installer.sh
SSS_SCRIPT       = src/dsm-control.sh
ADDITIONAL_SCRIPTS =

INSTALL_PREFIX = /usr/local/$(SPK_NAME)

include ../../mk/spksrc.spk.mk

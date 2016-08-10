PKG_NAME = comskip
PKG_VERS = 0.81.092
PKG_EXT = tar.gz
PKG_DOWNLOAD_METHOD = git
PKG_GIT_HASH = 53765ee
PKG_DIST_SITE = https://github.com/erikkaashoek/Comskip.git
PKG_DIST_FILE = $(PKG_NAME)-git$(PKG_GIT_HASH).$(PKG_EXT)
PKG_DIR = $(PKG_NAME)-git$(PKG_GIT_HASH)

DEPENDS = cross/ffmpeg-3.1 cross/argtable

HOMEPAGE = http://www.kaashoek.com/comskip
COMMENT  = Commercial detector
LICENSE  = GNU/LGPL

PRE_CONFIGURE_TARGET = myPreConfigure
GNU_CONFIGURE = 1
#ADDITIONAL_LDFLAGS="-Wl,-rpath,/usr/local/ffmpeg/lib/"

include ../../mk/spksrc.cross-cc.mk

.PHONY: myPreConfigure
myPreConfigure:
	$(RUN) ; ./autogen.sh

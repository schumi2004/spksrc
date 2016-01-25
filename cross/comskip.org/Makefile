PKG_NAME = Comskip
PKG_VERS = 0.81.089
PKG_EXT = tar.gz
PKG_DOWNLOAD_METHOD = git
PKG_GIT_HASH = 3c3af88478
PKG_DIST_NAME = Comskip.git
PKG_DIST_SITE = https://github.com/erikkaashoek
PKG_DIST_FILE = $(PKG_NAME)-git$(PKG_GIT_HASH).$(PKG_EXT)
PKG_DIR = $(PKG_NAME)-git*

DEPENDS = cross/ffmpeg-2.8.4 cross/argtable

HOMEPAGE = http://www.kaashoek.com/comskip
COMMENT  =
LICENSE  =

PRE_CONFIGURE_TARGET = myPreConfigure
GNU_CONFIGURE = 1

include ../../mk/spksrc.cross-cc.mk

myPreConfigure:
	$(RUN) ; ./autogen.sh

PKG_NAME = libvpx
PKG_VERS = 1.5.0
PKG_EXT = tar.gz
PKG_DOWNLOAD_METHOD = git
PKG_GIT_HASH = fbbd3f0
PKG_DIST_NAME = libvpx
PKG_DIST_SITE = https://chromium.googlesource.com/webm
PKG_DIST_FILE = $(PKG_NAME)-git$(PKG_GIT_HASH).$(PKG_EXT)
PKG_DIR = $(PKG_NAME)-git*
 
HOMEPAGE = http://www.webmproject.org/code/
COMMENT  = A high-quality, open video format for the web thats freely available to everyone.
LICENSE  =
 
CONFIGURE_ARGS = --enable-shared --disable-examples --disable-docs --disable-unit-tests --target=armv7-linux-gcc --prefix=$(INSTALL_DIR)/$(INSTALL_PREFIX)
 

include ../../mk/spksrc.cross-cc.mk

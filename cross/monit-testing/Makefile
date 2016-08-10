PKG_NAME = monit
PKG_VERS = 6.0
PKG_EXT = tar.gz
PKG_DOWNLOAD_METHOD = git
PKG_GIT_HASH = a115d60
PKG_DIST_SITE = https://bitbucket.org/tildeslash/monit.git
PKG_DIST_FILE = $(PKG_NAME)-git$(PKG_GIT_HASH).$(PKG_EXT)

PKG_DIR = $(PKG_NAME)-git$(PKG_GIT_HASH)

DEPENDS = cross/openssl

HOMEPAGE = http://mmonit.com/monit/
COMMENT  = Monit is a small Open Source utility for managing and monitoring Unix systems. Monit conducts automatic maintenance and repair and can execute meaningful causal actions in error situations.
LICENSE  = AGPL

GNU_CONFIGURE = 1
CONFIGURE_ARGS = --without-pam libmonit_cv_setjmp_available=yes libmonit_cv_vsnprintf_c99_conformant=yes --with-ssl-incl-dir=$(STAGING_INSTALL_PREFIX)/include
#ADDITIONAL_CFLAGS = -march=${ARCH}

include ../../mk/spksrc.cross-cc.mk

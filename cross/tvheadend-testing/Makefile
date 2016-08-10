PKG_NAME = tvheadend-testing
PKG_VERS = 4.1.2132
PKG_EXT = tar.gz
PKG_DOWNLOAD_METHOD = git
PKG_GIT_HASH = f34fac1
PKG_DIST_NAME = tvheadend.git
PKG_DIST_SITE = https://github.com/tvheadend
PKG_DIST_FILE = $(PKG_NAME)-git$(PKG_GIT_HASH).$(PKG_EXT)
PKG_DIR = $(PKG_NAME)-git*

DEPENDS = cross/openssl cross/curl cross/uriparser cross/ffmpeg-3.1 cross/libdvbcsa cross/comskip

HOMEPAGE = https://www.lonelycoder.com/tvheadend/
COMMENT  = Tvheadend is a TV streaming server for Linux supporting DVB-S, DVB-S2, DVB-C, DVB-T, ATSC, IPTV, and Analog video (V4L) as input sources
LICENSE  =

GNU_CONFIGURE = 1
CONFIGURE_ARGS = --enable-bundle --enable-imagecache --enable-uriparser --enable-libav --enable-dvbcsa --disable-avahi --enable-hdhomerun_static --release --disable-ffmpeg_static --nowerror
INSTALL_TARGET = myInstall

POST_EXTRACT_TARGET = post_extract_target_tvheadend-testing
PRE_PATCH_TARGET = pre_patch_target_tvheadend-testing
POST_PATCH_TARGET = post_patch_target_tvheadend-testing

ifneq ($(filter $(ARCH), ppc853x qoriq),)
        CONFIGURE_ARGS += --disable-inotify
endif

include ../../mk/spksrc.cross-cc.mk

.PHONY: myInstall
myInstall:
	$(RUN) make install DESTDIR=$(INSTALL_DIR)

pre_patch_target_tvheadend-testing:
	sed -i -e '8s|^.*$$|+  *) VER="$(PKG_VERS)" ;;|' $(PWD)/patches/version.patch

post_patch_target_tvheadend-testing:
	@if [ "$(ARCH)" = "ppc853x" ]; then \
		cat $(PWD)/patches/ppc853x/tvhpoll.c.patch | ($(RUN) patch -p0) ;\
	fi;
	@if [ "$(ARCH)" = "qoriq" ]; then \
		cat $(PWD)/patches/qoriq/tvhpoll.c.patch | ($(RUN) patch -p0) ;\
	fi;


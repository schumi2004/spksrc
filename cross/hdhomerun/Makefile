PKG_NAME = hdhomerun
PKG_VERS = 1.0.1
PKG_EXT = tgz
PKG_DIST_NAME = $(PKG_NAME)-$(PKG_VERS).$(PKG_EXT)
PKG_DIST_SITE = http://dierkse.nl/hdhomerun
PKG_DIR = $(PKG_NAME)-$(PKG_VERS)
KERNEL_FIRMWARE_VERSION = 5565

DEPENDS =

HOMEPAGE = http://www.hdhomerun.net
COMMENT  = Driver to use SiliconDust HDHomeRun DVB-T DVB-C ATSC tuners with Synology Diskstations. Supports up to 8 tuners.
LICENSE  = GPL

REQ_KERNEL = 1

PRE_DEPEND_TARGET = pre_depend_target_hdhomerun
POST_DEPEND_TARGET = post_depend_target_hdhomerun
PRE_CONFIGURE_TARGET = pre_configure_target_hdhomerun

include ../../mk/spksrc.cross-cc.mk

pre_depend_target_hdhomerun:
	mkdir -p $(PWD)/../../kernel/syno-$(ARCH)-$(TCVERSION)/patches
	cp $(KERNEL_FIRMWARE_VERSION)/kernel-config-$(ARCH).patch $(PWD)/../../kernel/syno-$(ARCH)-$(TCVERSION)/patches/kernel-config.patch
	sed -i -e 's|\./config|$(KERNEL_DIR)/synoconfigs/$(ARCH)|' $(PWD)/../../kernel/syno-$(ARCH)-$(TCVERSION)/patches/kernel-config.patch
	cp $(KERNEL_FIRMWARE_VERSION)/kernel-makefile-$(ARCH).patch $(PWD)/../../kernel/syno-$(ARCH)-$(TCVERSION)/patches/kernel-makefile.patch
	sed -i -e 's|0000|$(KERNEL_FIRMWARE_VERSION)|' $(PWD)/../../kernel/syno-$(ARCH)-$(TCVERSION)/patches/kernel-makefile.patch
	cd $(PWD)/../../kernel/syno-$(ARCH)-$(TCVERSION); cp Makefile Makefile.org; patch -p0 < patches/kernel-makefile.patch
	rm -f $(PWD)/../../kernel/syno-$(ARCH)-$(TCVERSION)/patches/kernel-makefile.patch

post_depend_target_hdhomerun:
	mv $(PWD)/../../kernel/syno-$(ARCH)-$(TCVERSION)/Makefile.org $(PWD)/../../kernel/syno-$(ARCH)-$(TCVERSION)/Makefile
	rm -rf $(PWD)/../../kernel/syno-$(ARCH)-$(TCVERSION)/patches

pre_configure_target_hdhomerun:
	sed -i -e 's|KERNEL_DIR\t:= .*|KERNEL_DIR\t:= $(KERNEL_DIR)|' $(WORK_DIR)/$(PKG_NAME)-$(PKG_VERS)/dvbhdhomerun/kernel/Makefile


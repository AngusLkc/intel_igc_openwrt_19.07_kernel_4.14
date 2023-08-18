include $(TOPDIR)/rules.mk
include $(INCLUDE_DIR)/kernel.mk

PKG_NAME:=igc
PKG_RELEASE:=1

include $(INCLUDE_DIR)/package.mk

define KernelPackage/$(PKG_NAME)
  DEPENDS:=@LINUX_4_14 @TARGET_x86
  TITLE:=Intel® i225/i226 2.5G Ethernet Adapter support
  SECTION:=kernel
  SUBMENU:=Network Devices
  FILES:=$(PKG_BUILD_DIR)/$(PKG_NAME).ko
  AUTOLOAD:=$(call AutoLoad,35,$(PKG_NAME))
endef

define KernelPackage/$(PKG_NAME)/description
  Kernel module to support Intel® i225/i226 2.5G Ethernet Adapter
endef

define Build/Prepare
	mkdir -p $(PKG_BUILD_DIR)
	$(CP) ./src/* $(PKG_BUILD_DIR)/
endef

define Build/Compile
	$(MAKE) -C "$(LINUX_DIR)" \
		$(KERNEL_MAKE_FLAGS) \
		SUBDIRS="$(PKG_BUILD_DIR)" \
		modules
endef

$(eval $(call KernelPackage,$(PKG_NAME)))

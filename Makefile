include $(TOPDIR)/rules.mk
include $(INCLUDE_DIR)/kernel.mk

PKG_NAME:=i225
PKG_RELEASE:=1

include $(INCLUDE_DIR)/package.mk

define KernelPackage/i225
  DEPENDS:=@LINUX_4_14
  TITLE:=Intel i225 2.5G Ethernet Support
  SECTION:=kernel
  SUBMENU:=Network Devices
  FILES:=$(PKG_BUILD_DIR)/igc.ko
  AUTOLOAD:=$(call AutoLoad,35,igc)
endef

define KernelPackage/i225/description
 Kernel module to support intel i225 2.5G Ethernet
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

$(eval $(call KernelPackage,i225))

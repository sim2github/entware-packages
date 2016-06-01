#
# Copyright (C) 2006-2016 OpenWrt.org
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

define Package/python3-dev
$(call Package/python3/Default)
  TITLE:=Python $(PYTHON3_VERSION) development files
  DEPENDS:=+python3
endef

define Py3Package/python3-dev/install
	$(INSTALL_DIR) $(1)/opt/bin
	$(CP) $(PKG_INSTALL_DIR)/opt/bin/python$(PYTHON3_VERSION)-config $(1)/opt/bin
	$(LN) python$(PYTHON3_VERSION)-config $(1)/opt/bin/python3-config
	$(LN) python$(PYTHON_VERSION)/config-$(PYTHON_VERSION)/libpython$(PYTHON3_VERSION).a $(1)/opt/lib/libpython$(PYTHON3_VERSION).a
endef

$(eval $(call Py3BasePackage,python3-dev, \
    /opt/lib/python$(PYTHON_VERSION)/config-$(PYTHON_VERSION) \
    /opt/include/python$(PYTHON_VERSION) \
    /opt/lib/pkgconfig \
))

include $(TOPDIR)/rules.mk

PKG_NAME:=https-dns-proxy
PKG_VERSION:=2019-12-03
PKG_RELEASE=2

PKG_SOURCE_PROTO:=git
PKG_SOURCE_URL:=https://github.com/aarond10/https_dns_proxy
PKG_SOURCE_DATE:=2019-12-03
PKG_SOURCE_VERSION:=2adeafb67cbe8d67148219c48334856ae4f3bd75
PKG_MIRROR_HASH:=58088baa092cd9634652d65f9b5650db88d2e102cb370710654db7b15f2f0e42
PKG_MAINTAINER:=Stan Grishin <stangri@melmac.net>
PKG_LICENSE:=MIT
PKG_LICENSE_FILES:=LICENSE

include $(INCLUDE_DIR)/package.mk
include $(INCLUDE_DIR)/cmake.mk

CMAKE_OPTIONS += -DCLANG_TIDY_EXE=

define Package/https-dns-proxy
	SECTION:=net
	CATEGORY:=Network
	TITLE:=DNS Over HTTPS Proxy
	DEPENDS:=+libcares +libcurl +libev +ca-bundle
	CONFLICTS:=https_dns_proxy
endef

define Package/https-dns-proxy/install
	$(INSTALL_DIR) $(1)/opt/sbin $(1)/opt/etc/init.d
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/https_dns_proxy $(1)/opt/sbin/https-dns-proxy
	$(INSTALL_BIN) ./files/S09https-dns-proxy $(1)/opt/etc/init.d/
endef

$(eval $(call BuildPackage,https-dns-proxy))

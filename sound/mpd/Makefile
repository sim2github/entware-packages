#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=mpd
PKG_VERSION:=0.21.16
PKG_RELEASE:=1

PKG_SOURCE:=$(PKG_NAME)-$(PKG_VERSION).tar.xz
PKG_SOURCE_URL:=http://www.musicpd.org/download/mpd/0.21/
PKG_HASH:=30cf1bddf7d7388487276745ad3515f134e07f0c57f9f97cb2b5d3befd4a4d92

PKG_MAINTAINER:=Ted Hess <thess@kitschensync.net>
PKG_LICENSE:=GPL-2.0-or-later
PKG_LICENSE_FILES:=COPYING

PKG_CONFIG_DEPENDS:= \
	CONFIG_IPV6 \

PKG_INSTALL:=1
PKG_USE_MIPS16:=0

include $(INCLUDE_DIR)/package.mk
include $(INCLUDE_DIR)/nls.mk
include ../../devel/meson/meson.mk

define Package/mpd/Default
  SECTION:=sound
  CATEGORY:=Sound
  TITLE:=Music Player Daemon
  URL:=http://www.musicpd.org/
  DEPENDS:= +zlib +libcurl +libpthread +libmpdclient +libstdcpp $(ICONV_DEPENDS) \
	    +AUDIO_SUPPORT:alsa-lib +boost +libexpat +libflac
endef

define Package/mpd/Default/description
 Music Player Daemon (MPD) is a flexible, powerful, server-side
 application for playing music. It is typically controlled over a
 network using one of it's many clients including mpc (console),
 gmpc (gnome), phpmp (php), etc...
endef

define Package/mpd-full
$(call Package/mpd/Default)
  TITLE+= (full)
  DEPENDS+= +libffmpeg +libid3tag +libvorbis +libmms +libupnp +libshout +pulseaudio-daemon +yajl
  PROVIDES:=mpd
  VARIANT:=full
endef

define Package/mpd-full/description
$(call Package/mpd/Default/description)
 .
 This package contains a full-blown Music Player Daemon.
endef

define Package/mpd-full/conffiles
/opt/etc/mpd.conf
endef

define Package/mpd-mini
$(call Package/mpd/Default)
  TITLE+= (mini)
  DEPENDS+= +libmpg123 +libvorbisidec
  PROVIDES:=mpd
  VARIANT:=mini
endef

define Package/mpd-mini/description
$(call Package/mpd/Default/description)
 .
 This package contains a minimal Music Player Daemon, with support for
 only Flac, MP3 & OGG media types & only file: & http: protocols.
endef

define Package/mpd-mini/conffiles
/opt/etc/mpd.conf
endef

define Package/mpd-avahi-service
$(call Package/mpd/Default)
  TITLE+= (Avahi service)
  DEPENDS+=+avahi-daemon
endef

define Package/mpd-avahi-service/description
$(call Package/mpd/Default/description)
 .
 This package contains the service definition for announcing the
 Music Player Daemon service via mDNS/DNS-SD.
endef

define Package/mpd-avahi-service/conffiles
/opt/etc/avahi/services/mpd.service
endef

EXTRA_LDFLAGS += $(if $(ICONV_FULL),-liconv,-Wl,--whole-archive -liconv -Wl,--no-whole-archive) -Wl,-rpath-link=$(STAGING_DIR)/opt/lib/pulseaudio

MESON_ARGS += \
	-Ddocumentation=false \
	-Dtest=false \
	-Dsyslog=enabled \
	-Dinotify=true \
	-Ddaemon=false \
	-Dsystemd=disabled \
	-Dtcp=true \
	-Dipv6=$(if $(CONFIG_IPV6),enabled,disabled) \
	-Dlocal_socket=true \
	-Ddsd=false \
	-Ddatabase=true \
	-Dlibmpdclient=enabled \
	-Dneighbor=false \
	-Dudisks=disabled \
	-Dwebdav=enabled \
	-Dcue=true \
	-Dcdio_paranoia=disabled \
	-Dcurl=enabled \
	-Dnfs=disabled \
	-Dsmbclient=disabled \
	-Dqobuz=disabled \
	-Dtidal=disabled \
	-Dbzip2=disabled \
	-Diso9660=disabled \
	-Dzzip=disabled \
	-Dchromaprint=disabled \
	-Dadplug=disabled \
	-Daudiofile=disabled \
	-Dfaad=disabled \
	-Dflac=enabled \
	-Dfluidsynth=disabled \
	-Dgme=disabled \
	-Dmad=disabled \
	-Dmikmod=disabled \
	-Dmodplug=disabled \
	-Dmpcdec=disabled \
	-Dopus=disabled \
	-Dsidplay=disabled \
	-Dsndfile=disabled \
	-Dwavpack=disabled \
	-Dwildmidi=disabled \
	-Dvorbisenc=disabled \
	-Dlame=disabled \
	-Dtwolame=disabled \
	-Dshine=disabled \
	-Dwave_encoder=true \
	-Dlibsamplerate=disabled \
	-Dsoxr=disabled \
	-Dalsa=$(if $(CONFIG_AUDIO_SUPPORT),enabled,disabled) \
	-Dao=disabled \
	-Dhttpd=true \
	-Djack=disabled \
	-Dopenal=disabled \
	-Doss=disabled \
	-Dsndio=disabled \
	-Dsolaris_output=disabled \
	-Ddbus=disabled \
	-Dexpat=enabled \
	-Dicu=disabled \
	-Diconv=enabled \
	-Dpcre=disabled \
	-Dsqlite=disabled \
	-Dzlib=enabled \
	-Dzeroconf=disabled


ifeq ($(BUILD_VARIANT),full)

  MESON_ARGS += \
	-Dupnp=enabled \
	-Dmms=enabled \
	-Dsoundcloud=enabled \
	-Did3tag=enabled \
	-Dffmpeg=enabled \
	-Dmpg123=disabled \
	-Dtremor=disabled \
	-Dvorbis=enabled \
	-Dfifo=true \
	-Dpipe=true \
	-Dpulse=enabled \
	-Drecorder=true \
	-Dshout=enabled \
	-Dyajl=enabled
endif

ifeq ($(BUILD_VARIANT),mini)

  # oggflac is not compatible with tremor
  MESON_ARGS += \
	-Dupnp=disabled \
	-Dmms=disabled \
	-Dsoundcloud=disabled \
	-Did3tag=disabled \
	-Dffmpeg=disabled \
	-Dmpg123=enabled \
	-Dtremor=enabled \
	-Dvorbis=disabled \
	-Dfifo=false \
	-Dpipe=false \
	-Dpulse=disabled \
	-Drecorder=false \
	-Dshout=disabled \
	-Dyajl=disabled
endif

define Package/mpd/install
	$(INSTALL_DIR) $(1)/opt/bin
	$(INSTALL_BIN) $(PKG_INSTALL_DIR)/opt/bin/mpd $(1)/opt/bin/
	$(INSTALL_DIR) $(1)/opt/etc
	$(INSTALL_CONF) $(PKG_BUILD_DIR)/doc/mpdconf.example $(1)/opt/etc/mpd.conf
	$(INSTALL_DIR) $(1)/opt/etc/init.d
	$(INSTALL_BIN) ./files/S89mpd $(1)/opt/etc/init.d/
endef

define Package/mpd-full/install
$(call Package/mpd/install,$1)
endef

define Package/mpd-mini/install
$(call Package/mpd/install,$1)
endef

define Package/mpd-avahi-service/install
	$(INSTALL_DIR) $(1)/opt/etc/avahi/services
	$(INSTALL_DATA) ./files/mpd.service $(1)/opt/etc/avahi/services/
endef

$(eval $(call BuildPackage,mpd-full))
$(eval $(call BuildPackage,mpd-mini))
$(eval $(call BuildPackage,mpd-avahi-service))

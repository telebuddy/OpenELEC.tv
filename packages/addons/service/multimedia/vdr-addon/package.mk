################################################################################
#      This file is part of OpenELEC - http://www.openelec.tv
#      Copyright (C) 2009-2014 Stephan Raue (stephan@openelec.tv)
#      Copyright (C) 2011 Anthony Nash (nash.ant@gmail.com)
#
#  OpenELEC is free software: you can redistribute it and/or modify
#  it under the terms of the GNU General Public License as published by
#  the Free Software Foundation, either version 2 of the License, or
#  (at your option) any later version.
#
#  OpenELEC is distributed in the hope that it will be useful,
#  but WITHOUT ANY WARRANTY; without even the implied warranty of
#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#  GNU General Public License for more details.
#
#  You should have received a copy of the GNU General Public License
#  along with OpenELEC.  If not, see <http://www.gnu.org/licenses/>.
################################################################################

PKG_NAME="vdr-addon"
PKG_VERSION="6.0"
PKG_REV="0"
PKG_ARCH="any"
PKG_LICENSE="GPL"
PKG_SITE="http://www.openelec.tv"
PKG_URL=""
PKG_DEPENDS_TARGET="toolchain attr libcap vdr vdr-plugin-vnsiserver vdr-wirbelscan vdr-wirbelscancontrol vdr-plugin-dvbapi vdr-live vdr-epgsearch vdr-plugin-xmltv2vdr vdr-plugin-restfulapi"
PKG_PRIORITY="optional"
PKG_SECTION="service.multimedia"
PKG_SHORTDESC="vdr: A powerful DVB TV application"
PKG_LONGDESC="This project describes how to build your own digital satellite receiver and video disk recorder. It is based mainly on the DVB-S digital satellite receiver card, which used to be available from Fujitsu Siemens and the driver software developed by the LinuxTV project."
PKG_AUTORECONF="no"
PKG_IS_ADDON="yes"
PKG_ADDON_TYPE="xbmc.service"
PKG_ADDON_PROVIDES=""
PKG_ADDON_REQUIRES="pvr.vdr.vnsi:0.0.0"
PKG_ADDON_NAME="VDR PVR Backend"

make_target() {
  : # nothing to do here
}

makeinstall_target() {
  : # nothing to do here
}

addon() {
  VDR_DIR="$(get_build_dir vdr)"
  VDR_LIVE_DIR="$(get_build_dir vdr-live)"
  VDR_PLUGIN_VNSISERVER_DIR="$(get_build_dir vdr-plugin-vnsiserver)"
  VDR_PLUGIN_RESTFULAPI_DIR="$(get_build_dir vdr-plugin-restfulapi)"

  mkdir -p $ADDON_BUILD/$PKG_ADDON_ID/config
  touch $ADDON_BUILD/$PKG_ADDON_ID/config/channels.conf
  cp $VDR_DIR/diseqc.conf $ADDON_BUILD/$PKG_ADDON_ID/config
  cp $VDR_DIR/keymacros.conf $ADDON_BUILD/$PKG_ADDON_ID/config
  cp $VDR_DIR/scr.conf $ADDON_BUILD/$PKG_ADDON_ID/config
  cp $VDR_DIR/sources.conf $ADDON_BUILD/$PKG_ADDON_ID/config
  cp $VDR_DIR/svdrphosts.conf $ADDON_BUILD/$PKG_ADDON_ID/config
  echo '0.0.0.0/0' >> $ADDON_BUILD/$PKG_ADDON_ID/config/svdrphosts.conf

  mkdir -p $ADDON_BUILD/$PKG_ADDON_ID/config/plugins/epgsearch

  mkdir -p $ADDON_BUILD/$PKG_ADDON_ID/res/plugins/live
  cp -PR $VDR_LIVE_DIR/live/* $ADDON_BUILD/$PKG_ADDON_ID/res/plugins/live

  mkdir -p $ADDON_BUILD/$PKG_ADDON_ID/config/plugins

  mkdir -p $ADDON_BUILD/$PKG_ADDON_ID/plugin
  cp -PR $VDR_PLUGIN_VNSISERVER_DIR/libvdr*.so.* $ADDON_BUILD/$PKG_ADDON_ID/plugin
  cp -PR $(get_build_dir vdr-wirbelscan)/libvdr*.so.* $ADDON_BUILD/$PKG_ADDON_ID/plugin
  cp -PR $(get_build_dir vdr-wirbelscancontrol)/libvdr*.so.* $ADDON_BUILD/$PKG_ADDON_ID/plugin
  cp -PR $(get_build_dir vdr-plugin-dvbapi)/libvdr*.so.* $ADDON_BUILD/$PKG_ADDON_ID/plugin
  cp -PR $VDR_LIVE_DIR/libvdr*.so.* $ADDON_BUILD/$PKG_ADDON_ID/plugin
  cp -PR $VDR_PLUGIN_RESTFULAPI_DIR/libvdr*.so.* $ADDON_BUILD/$PKG_ADDON_ID/plugin

  mkdir -p $ADDON_BUILD/$PKG_ADDON_ID/config/plugins/vnsiserver
  cp -PR $VDR_PLUGIN_VNSISERVER_DIR/vnsiserver/allowed_hosts.conf $ADDON_BUILD/$PKG_ADDON_ID/config/plugins/vnsiserver

  mkdir -p $ADDON_BUILD/$PKG_ADDON_ID/bin
  cp -P $VDR_DIR/vdr $ADDON_BUILD/$PKG_ADDON_ID/bin/vdr.bin

  mkdir -p $ADDON_BUILD/$PKG_ADDON_ID/lib
  cp -PL $(get_build_dir tntnet)/.install_pkg/usr/lib/libtntnet.so.12 $ADDON_BUILD/$PKG_ADDON_ID/lib

  mkdir -p $ADDON_BUILD/$PKG_ADDON_ID/res/plugins/restfulapi
  cp -P $VDR_PLUGIN_RESTFULAPI_DIR/web/* $ADDON_BUILD/$PKG_ADDON_ID/res/plugins/restfulapi
  cp -P $VDR_PLUGIN_RESTFULAPI_DIR/API.html $ADDON_BUILD/$PKG_ADDON_ID/res/plugins/restfulapi
  
  sed -e "s|^default=\"/storage/videos\"|default=\"/storage/recordings\"|" \	  
      -i $ADDON_BUILD/$PKG_ADDON_ID/resources/settings.xml
}

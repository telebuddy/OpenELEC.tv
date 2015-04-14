################################################################################
#      This file is part of OpenELEC - http://www.openelec.tv
#      Copyright (C) 2009-2014 Stephan Raue (stephan@openelec.tv)
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

PKG_NAME="kodi-lcdproc"
PKG_VERSION="2.6.0"
PKG_REV="1"
PKG_ARCH="any"
PKG_LICENSE="GPL"
PKG_SITE="https://github.com/herrnst/script.xbmc.lcdproc"
PKG_URL="$AZURE_SRC/$PKG_NAME-$PKG_VERSION.zip"
PKG_DEPENDS_TARGET="toolchain Python pygobject kodi"
PKG_PRIORITY="optional"
PKG_SECTION="multimedia"
PKG_SHORTDESC="kodi-lcdproc: LCDProc Addon for OpenELEC"
PKG_LONGDESC="kodi-lcdproc: LCDProc Addon for OpenELEC"

PKG_IS_ADDON="no"
PKG_AUTORECONF="no"

make_target() {
  : #nop
}

makeinstall_target() {
  mkdir -p $INSTALL/usr/share/kodi/addons/script.xbmc.lcdproc
    cp -R */ $INSTALL/usr/share/kodi/addons/script.xbmc.lcdproc
}

post_makeinstall_target() {
  python -Wi -t -B $ROOT/$TOOLCHAIN/lib/python2.7/compileall.py $INSTALL/usr/share/kodi/addons/service.xbmc.lcdproc/resources/lib/ -f
  rm -rf `find $INSTALL/usr/share/kodi/addons/service.xbmc.lcdproc/resources/lib/ -name "*.py"`
}

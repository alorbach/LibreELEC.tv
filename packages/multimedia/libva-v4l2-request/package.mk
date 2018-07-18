# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2018 Team LibreELEC (https://libreelec.tv)

PKG_NAME="libva-v4l2-request"
PKG_VERSION="3e442a19b6544b038e2bdee3cc9ec111c2f125cc"
PKG_ARCH="any"
PKG_LICENSE="LGPL+MIT"
PKG_SITE="https://www.bootlin.com"
PKG_URL="https://github.com/bootlin/libva-v4l2-request/archive/$PKG_VERSION.tar.gz"
PKG_SOURCE_DIR="libva-v4l2-request-$PKG_VERSION*"
PKG_SECTION="multimedia"
PKG_SHORTDESC="libva-v4l2-request"
PKG_LONGDESC="libva-v4l2-request"
PKG_TOOLCHAIN="autotools"

if [ "$DISPLAYSERVER" = "weston" ]; then
  PKG_DEPENDS_TARGET="toolchain libdrm wayland"
else
  PKG_DEPENDS_TARGET="toolchain libdrm libva"
fi

PKG_CONFIGURE_OPTS_TARGET=""

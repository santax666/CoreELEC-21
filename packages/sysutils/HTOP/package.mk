# SPDX-License-Identifier: GPL-2.0
# Copyright (C) 2016-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="HTOP"
PKG_VERSION="3.3.0"
PKG_SHA256="1e5cc328eee2bd1acff89f860e3179ea24b85df3ac483433f92a29977b14b045"
PKG_LICENSE="GPL"
PKG_SITE="https://hisham.hm/htop"
PKG_URL="https://github.com/htop-dev/htop/archive/${PKG_VERSION}.tar.gz"
PKG_DEPENDS_TARGET="toolchain ncurses"
PKG_LONGDESC="An interactive process viewer for Unix."
PKG_TOOLCHAIN="autotools"
PKG_BUILD_FLAGS="-sysroot"

PKG_CONFIGURE_OPTS_TARGET="--disable-unicode \
                           HTOP_NCURSES_CONFIG_SCRIPT=ncurses-config"

pre_configure_target() {
  export LDFLAGS="${LDFLAGS} -pthread"
}

post_makeinstall_target() {
  rm -rf $INSTALL/usr/share
}

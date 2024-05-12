# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2009-2012 Stephan Raue (stephan@openelec.tv)
# Copyright (C) 2016-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="MC"
PKG_VERSION="4.8.31"
PKG_SHA256="24191cf8667675b8e31fc4a9d18a0a65bdc0598c2c5c4ea092494cd13ab4ab1a"
PKG_LICENSE="GPL"
PKG_SITE="http://www.midnight-commander.org/"
PKG_URL="http://ftp.midnight-commander.org/mc-${PKG_VERSION}.tar.xz"
PKG_DEPENDS_TARGET="toolchain gettext:host glib libssh2 libtool:host slang pcre2"
PKG_LONGDESC="Midnight Commander is a visual file manager"
PKG_BUILD_FLAGS="-sysroot"

PKG_CONFIGURE_OPTS_TARGET=" \
  --prefix=/usr \
  --sysconfdir=/etc \
  --with-sysroot=$SYSROOT_PREFIX \
  --with-screen=slang \
  --with-slang-includes=$SYSROOT_PREFIX/usr/include \
  --with-slang-libs=$SYSROOT_PREFIX/usr/lib \
  --disable-aspell \
  --without-diff-viewer \
  --disable-doxygen-doc \
  --disable-doxygen-dot \
  --disable-doxygen-html \
  --with-gnu-ld \
  --without-libiconv-prefix \
  --without-libintl-prefix \
  --with-internal-edit \
  --disable-mclib \
  --with-subshell \
  --with-edit \
  --enable-vfs-extfs \
  --enable-vfs-ftp \
  --enable-vfs-sftp \
  --enable-vfs-tar \
  --with-search-engine=pcre2 \
  --with-pcre2=${SYSROOT_PREFIX}/usr \
  --without-x"

pre_configure_target() {
  LDFLAGS+=" -lcrypto -lssl"
}

post_makeinstall_target() {
  mv $INSTALL/usr/bin/mc $INSTALL/usr/bin/mc-bin
  rm -f $INSTALL/usr/bin/{mcedit,mcview}
  cp $PKG_DIR/wrapper/* $INSTALL/usr/bin

  mkdir -p  $INSTALL/usr/config
    mv $INSTALL/etc/mc $INSTALL/usr/config/
    ln -sf /storage/.config/mc $INSTALL/etc/mc
}

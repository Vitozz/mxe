# This file is part of MXE. See LICENSE.md for licensing information.

PKG             := libsrtp
$(PKG)_WEBSITE  := https://github.com/cisco/libsrtp
$(PKG)_DESCR    := Secure Real-time Transport Protocol Library
$(PKG)_IGNORE   :=
$(PKG)_VERSION  := 2.8.1
$(PKG)_CHECKSUM := ef5569220749529d778013aae1178391d972570a2b4f7288dda22effa875b07c
$(PKG)_GH_CONF  := cisco/libsrtp/tags, v
$(PKG)_DEPS     := cc meson-wrapper

define $(PKG)_BUILD
'$(MXE_MESON_WRAPPER)' $(MXE_MESON_OPTS) \
        $(PKG_MESON_OPTS) \
        '$(BUILD_DIR)' '$(SOURCE_DIR)'
    '$(MXE_NINJA)' -C '$(BUILD_DIR)' -j '$(JOBS)' install
endef

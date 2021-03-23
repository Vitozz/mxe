# This file is part of MXE. See LICENSE.md for licensing information.

PKG             := libcue
$(PKG)_WEBSITE  := https://github.com/lipnitsk/libcue
$(PKG)_DESCR    := CUE Sheet Parser Library
$(PKG)_IGNORE   :=
$(PKG)_VERSION  := 2.2.1
$(PKG)_CHECKSUM := f27bc3ebb2e892cd9d32a7bee6d84576a60f955f29f748b9b487b173712f1200
$(PKG)_GH_CONF  := lipnitsk/libcue/releases/latest, v
$(PKG)_DEPS     := cc

define $(PKG)_BUILD
    cd '$(BUILD_DIR)' && $(TARGET)-cmake '$(SOURCE_DIR)'
    $(MAKE) -C '$(BUILD_DIR)' -j '$(JOBS)'
    $(MAKE) -C '$(BUILD_DIR)' -j 1 install
endef

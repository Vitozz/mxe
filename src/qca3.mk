# This file is part of MXE. See LICENSE.md for licensing information.

PKG             := qca3
$(PKG)_WEBSITE  := https://github.com/psi-im/qca
$(PKG)_DESCR    := Qt Cryptographic Architecture
$(PKG)_IGNORE   :=
$(PKG)_VERSION  := 3.0.6
$(PKG)_CHECKSUM := 9c780211bbef1191fbf32f62b3c9fe5595fc282f228a3de792d0c442a736dc8a
$(PKG)_GH_CONF  := psi-im/qca/tags,v
$(PKG)_DEPS     := cc openssl qtbase

define $(PKG)_BUILD
    cd '$(BUILD_DIR)' && $(TARGET)-cmake '$(SOURCE_DIR)' \
	-DCMAKE_INSTALL_PREFIX=$(PREFIX)/$(TARGET) \
        -DBUILD_TESTS=OFF \
        -DBUILD_TOOLS=OFF \
        -DUSE_RELATIVE_PATHS=OFF \
        -DBUILD_PLUGINS="auto" \
        -DQCA_MAN_INSTALL_DIR="$(BUILD_DIR)/null"
    $(MAKE) -C '$(BUILD_DIR)' -j $(JOBS)
    $(MAKE) -C '$(BUILD_DIR)' -j 1 install

    # build test as cmake project
    mkdir '$(BUILD_DIR).test-cmake'
    cd '$(BUILD_DIR).test-cmake' && $(TARGET)-cmake \
        -DPKG=$(PKG) \
        '$(PWD)/src/cmake/test'
    $(MAKE) -C '$(BUILD_DIR).test-cmake' -j 1 install VERBOSE=ON

    # build test manually
    '$(TARGET)-g++' \
        -W -Wall -Werror -std=gnu++17 -Wno-deprecated-copy \
        '$(PWD)/src/qca3-test.cpp' \
        -o '$(PREFIX)/$(TARGET)/bin/test-$(PKG)-pkgconfig.exe' \
        $(if $(BUILD_STATIC), -L'$(PREFIX)/$(TARGET)/qca3-qt5/crypto' -lqca3-ossl) \
        `'$(TARGET)-pkg-config' qca3-qt5 --cflags --libs`
endef

$(PKG)_BUILD_STATIC =

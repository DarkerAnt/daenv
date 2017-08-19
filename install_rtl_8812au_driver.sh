#!/bin/sh

source utils/install.sh

pkg_install kernel-devel kernel-headers dkms
git clone https://github.com/abperiasamy/rtl8812AU_8821AU_linux.git ~/src/rtl8812AU_8821AU_linux
pushd ~/src/rtl8812AU_8821AU_linux
sudo make -f Makefile.dkms install
popd

#!/bin/sh

set -eu

ARCH=$(uname -m)

echo "Installing package dependencies..."
echo "---------------------------------------------------------------"
make-aur-package libtiff5
make-aur-package libjpeg6-turbo
make-aur-package ffmpeg7.1
pacman -Syu --noconfirm libbluray libmng
PRE_BUILD_CMDS="
sed -i 's/^pkgver=.*/pkgver=27.0.0.1/' ./PKGBUILD
sed -i 's/sha256sums=('8bb7c6f12765fefe500324ec0a1e8e29ee010d89d0d2304981276a30eae42cda')/sha256sums=('15dcf07959270999a8015c4ffdb933f4a7f095fbccf23880a86a3ce7dc622390')/ ./PKGBUILD
"
make-aur-package viber

if [ "$ARCH" = 'x86_64' ]; then
	pacman -Syu --noconfirm libva-intel-driver
fi

echo "Installing debloated packages..."
echo "---------------------------------------------------------------"
# Don't install qt6-base, as it breaks Viber and Viber already bundles it's own qt6
get-debloated-pkgs --add-common --prefer-nano intel-media-driver-mini ! qt6-base

mkdir -p ./AppDir/bin
cp -rv /opt/viber/*               ./AppDir/bin

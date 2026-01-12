#!/bin/sh

set -eu

ARCH=$(uname -m)

echo "Installing package dependencies..."
echo "---------------------------------------------------------------"
make-aur-package libtiff5
make-aur-package libjpeg6-turbo
make-aur-package ffmpeg7.1
make-aur-package

if [ "$ARCH" = 'x86_64' ]; then
	pacman -Syu --noconfirm libva-intel-driver
fi

echo "Installing debloated packages..."
echo "---------------------------------------------------------------"
# Don't install qt6-base, as it breaks Viber and Viber already bundles it's own qt6
get-debloated-pkgs --add-common --prefer-nano intel-media-driver-mini ! qt6-base

mkdir -p ./AppDir/bin
cp -rv /opt/viber/*               ./AppDir/bin

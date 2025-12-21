#!/bin/sh

set -eu

ARCH=$(uname -m)

echo "Installing package dependencies..."
echo "---------------------------------------------------------------"
make-aur-package viber
pacman -Syu --noconfirm libtiff5 libtheora

echo "Installing debloated packages..."
echo "---------------------------------------------------------------"
# Don't install qt6-base, as it breaks Viber and Viber already bundles it's own qt6
get-debloated-pkgs --add-common --prefer-nano ffmpeg-mini ! qt6-base

mkdir -p ./AppDir/bin
cp -rv /opt/viber/*               ./AppDir/bin

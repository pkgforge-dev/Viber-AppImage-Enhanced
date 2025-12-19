#!/bin/sh

set -eu

ARCH=$(uname -m)

echo "Installing package dependencies..."
echo "---------------------------------------------------------------"
make-aur-package viber

echo "Installing debloated packages..."
echo "---------------------------------------------------------------"
get-debloated-pkgs --add-common --prefer-nano
# Remove qt6-base, as it breaks Viber and Viber already bundles it's own qt6
pacman -Rdd --noconfirm qt6-base

mkdir -p ./AppDir/bin
cp -rv /opt/viber/*               ./AppDir/bin

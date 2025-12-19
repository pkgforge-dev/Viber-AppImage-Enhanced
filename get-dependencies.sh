#!/bin/sh

set -eu

ARCH=$(uname -m)

echo "Installing package dependencies..."
echo "---------------------------------------------------------------"
make-aur-package viber
pacman -Syu --noconfirm qt6-base qt6-charts

echo "Installing debloated packages..."
echo "---------------------------------------------------------------"
get-debloated-pkgs --add-common --prefer-nano

mkdir -p ./AppDir/bin
cp -rv /opt/viber/*               ./AppDir/bin

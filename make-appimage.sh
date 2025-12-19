#!/bin/sh

set -eu

ARCH=$(uname -m)
VERSION=$(pacman -Q viber | awk '{print $2; exit}')
export ARCH VERSION
export OUTPATH=./dist
export ADD_HOOKS="self-updater.bg.hook:fix-namespaces.hook"
export UPINFO="gh-releases-zsync|${GITHUB_REPOSITORY%/*}|${GITHUB_REPOSITORY#*/}|latest|*$ARCH.AppImage.zsync"
export ICON=/usr/share/icons/hicolor/scalable/apps/viber.svg
export DESKTOP=/usr/share/applications/viber.desktop
export DEPLOY_PIPEWIRE=1
export DEPLOY_GSTREAMER=1
export DEPLOY_OPENGL=1
export DEPLOY_VULKAN=1
# Viber already bundles those libs already
export DEPLOY_QT=0
export DEPLOY_QML=0
export DEPLOY_QT_WEB_ENGINE=0

# Deploy dependencies
quick-sharun ./AppDir/bin/*

sed -e 's|Exec=viber|Exec=Viber|g' -i ./AppDir/viber.desktop

# Turn AppDir into AppImage
quick-sharun --make-appimage

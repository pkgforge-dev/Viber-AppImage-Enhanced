#!/bin/sh

set -eu

ARCH=$(uname -m)
VERSION=$(pacman -Q viber | awk '{print $2; exit}')
export ARCH VERSION
export OUTPATH=./dist
export ADD_HOOKS="self-updater.bg.hook:fix-namespaces.hook"
export UPINFO="gh-releases-zsync|${GITHUB_REPOSITORY%/*}|${GITHUB_REPOSITORY#*/}|latest|*$ARCH.AppImage.zsync"
export ICON=/usr/share/icons/hicolor/scalable/apps/viber.svg
export DESKTOP=/usr/share/applications/com.viber.Viber.desktop
export MAIN_BIN=Viber
export DEPLOY_PIPEWIRE=1
export DEPLOY_OPENGL=1
export DEPLOY_VULKAN=1
# We default to Wayland's StartupWMClass here, as it's the most used on the Linux desktop.
# X11's StartupWMClass is ViberPC, so that needs to be manually changed for X11 users,
# or some automatic solution needs to be implemented for Qt apps, like it is implemented for Gtk apps here
# https://github.com/pkgforge-dev/Anylinux-AppImages/blob/7765034a995ecd46e876d2d6360d8f411fa737ab/useful-tools/lib/gtk-class-fix.c
export STARTUPWMCLASS=com.viber.Viber
# Viber bundles those libs already
export DEPLOY_QT=0
export DEPLOY_QML=0
export DEPLOY_QT_WEB_ENGINE=0

# We used this when Viber linked to the older version of 'libtheora', which is not required anymore
# However, we will still remove those ffmpeg libs and use the ones provided by Arch Linux
rm -fv ./AppDir/bin/lib/libavcodec* 
rm -fv ./AppDir/bin/lib/libavdevice*
rm -fv ./AppDir/bin/lib/libavfilter*
rm -fv ./AppDir/bin/lib/libavformat*
rm -fv ./AppDir/bin/lib/libavutil*
rm -fv ./AppDir/bin/lib/libpostproc*
rm -fv ./AppDir/bin/lib/libswresample*
rm -fv ./AppDir/bin/lib/libswscale*

# Deploy dependencies
quick-sharun ./AppDir/bin/* \
             ./AppDir/bin/libexec/* \
             /usr/lib/libmng*

## Fix desktop file exec to be for the real executable
sed -e 's|Exec=viber|Exec=Viber|g' -i ./AppDir/com.viber.Viber.desktop
sed -i '/Path=/d' ./AppDir/com.viber.Viber.desktop

# Turn AppDir into AppImage
quick-sharun --make-appimage

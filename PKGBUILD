# Maintainer: Sandor Nagy <sandor[dot]nagy[at]kdemail[dot]net>
# Contributor: Mladen Pejaković <pejakm[at]autistici[dot]org>
# Contributor: Morealaz <morealaz@gmail.com>
# Contributor: Lev Lybin <lev.lybin@gmail.com>
# Contributor: Özgür Sarıer <ozgursarier1011601115[at]gmail[dot]com>

pkgname=viber
pkgver=27.3.0.2
pkgrel=1
pkgdesc="Proprietary cross-platform IM and VoIP software"
arch=('x86_64')
url='https://www.viber.com'
license=('custom')
depends=('xcb-util-cursor' 'xcb-util-image' 'xcb-util-keysyms' 'xcb-util-renderutil' 'xcb-util-wm' 'libxss'
	'openssl' 'libpulse' 'alsa-lib' 'nss' 'libxcomposite' 'libxcursor' 'libxdamage' 'libxslt'
	'snappy' 'numactl' 'libxml2-legacy' 'libjpeg6-turbo' 'libtiff5' 'ffmpeg7.1' 'libbluray' 'libmng' 'harfbuzz' 'pipewire-audio')
options=('!strip')
source=("$pkgname-$pkgver.deb::https://download.cdn.viber.com/cdn/desktop/Linux/viber.deb")
sha256sums=('961534dc0cb920006ec7ae8108b0e1ba09a476eef1e13b4b370a79cd52dd20f3')

prepare() {
  cd "$srcdir"

  tar -xf control.tar.xz

  tar -Jxf data.tar.xz

  sed -e 's|Exec=/opt/viber/Viber|Exec=viber|g' \
      -e 's|/usr/share/pixmaps/viber.png|viber.png|g' \
      -i usr/share/applications/viber.desktop
}

package() {
  cd "$srcdir"

  install -dm755 "$pkgdir/opt"
  cp -dpr --no-preserve=ownership "$srcdir/opt/viber/" "$pkgdir/opt/"
  install -Dm644 usr/share/applications/viber.desktop "$pkgdir/usr/share/applications/com.viber.Viber.desktop"
  install -Dm644 copyright "$pkgdir/usr/share/licenses/viber/LICENSE"

  install -dm755 "$pkgdir/usr/bin/"
  ln -s /opt/viber/Viber "$pkgdir/usr/bin/viber"

  # install icons
  cd "$srcdir/usr/share/viber"
  for iconsize in 16x16 24x24 32x32 48x48 64x64 96x96 128x128 256x256; do
    install -Dm644 icons/$iconsize.png "$pkgdir/usr/share/icons/hicolor/$iconsize/apps/viber.png"
  done
  install -Dm644 usr/share/icons/hicolor/scalable/apps/Viber.svg "$pkgdir/usr/share/icons/hicolor/scalable/apps/viber.svg"
}

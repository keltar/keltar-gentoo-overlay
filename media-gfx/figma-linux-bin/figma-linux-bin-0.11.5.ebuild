# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7
inherit unpacker xdg

DESCRIPTION="Unofficial desktop application for linux"
HOMEPAGE="https://github.com/ChugunovRoman/figma-linux"
SRC_URI="https://github.com/Figma-Linux/figma-linux/releases/download/v${PV}/figma-linux_${PV}_linux_amd64.deb -> ${P}.deb"

LICENSE="MIT"
SLOT="0"
KEYWORDS="-* ~amd64"
RESTRICT="bindist mirror"
IUSE="appindicator doc libnotify"

RDEPEND="app-accessibility/at-spi2-core
	app-crypt/libsecret
	dev-libs/expat
	dev-libs/libbsd
	dev-libs/nss
	media-libs/libpng
	sys-apps/dbus
	sys-apps/keyutils
	sys-apps/util-linux
	sys-libs/zlib
	x11-libs/gtk+:3
	x11-libs/libXScrnSaver
	x11-libs/libXtst
	x11-misc/xdg-utils
	appindicator? ( dev-libs/libappindicator )
	libnotify? ( x11-libs/libnotify )"

QA_PREBUILT="*"

S=${WORKDIR}

src_prepare() {
	default

	if use doc ; then
		unpack "usr/share/doc/figma-linux/changelog.gz" || die "unpack failed"
		rm -f "usr/share/doc/figma-linux/changelog.gz" || die "rm failed"
		mv "changelog" "usr/share/doc/figma-linux" || die "mv failed"
	fi

	rm -rf opt/figma-linux/lib || die
	rm -rf opt/figma-linux/usr || die
	rm -f opt/figma-linux/libpng16.so.16 || die
	rm -f opt/figma-linux/libz.so.1 || die
	rm -f opt/figma-linux/libvulkan.so.1 || die
}

src_install() {
	cp -a . "${ED}" || die "cp failed"

	rm -r "${ED}/usr/share/doc/figma-linux" || die "rm failed"

	if use doc ; then
		dodoc -r "usr/share/doc/figma-linux/"* || die "dodoc failed"
	fi

	dosym "/opt/figma-linux/figma-linux" "/usr/bin/figma-linux" || die "dosym failed"
}

# Copyright 2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8
inherit unpacker xdg

DESCRIPTION="Pachca IM client"
HOMEPAGE="https://www.pachca.com"
SRC_URI="https://install.pachca.com/Pachca-2.4.0-amd64.deb -> ${P}.deb"

LICENSE="Pachca"
SLOT="0"
KEYWORDS="~amd64"

DEPEND="
	sys-libs/glibc
	dev-libs/glib
	dev-libs/nss
	dev-libs/nspr
	sys-apps/dbus
	app-accessibility/at-spi2-core
	net-print/cups
	x11-libs/libdrm
	x11-libs/gtk+:3
	x11-libs/pango
	x11-libs/cairo
	x11-libs/libxcb
	dev-libs/expat
	media-libs/alsa-lib
"
RDEPEND="${DEPEND}"
BDEPEND=""

S=${WORKDIR}

src_prepare() {
	default

	rm -rf usr/share/doc
	sed -i -e "s/Categories=Utility;/Categories=Network;InstantMessaging;/g" \
		usr/share/applications/Pachca.desktop || die ".desktop patch failed"
}

src_install() {
	cp -a . "${ED}" || die "cp failed"
	dosym "/opt/Pachca/Pachca" "/usr/bin/Pachca" || die "dosym failed"
}

# Copyright 2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit desktop xdg

MY_PN=${PN/-/_}

DESCRIPTION="Git Client, dome Sublime"
HOMEPAGE="https://www.sublimemerge.com"
SRC_URI="
	amd64? ( https://download.sublimetext.com/${MY_PN}_build_${PV}_x64.tar.xz )
"

LICENSE="Sublime"
SLOT="0"
KEYWORDS="~amd64"
RESTRICT="bindist mirror strip"

RDEPEND="
	dev-vcs/git
	dev-libs/glib:2
	x11-libs/gtk+:3
	x11-libs/libX11
	media-libs/libglvnd
"

QA_PREBUILD="*"
S="${WORKDIR}/${MY_PN}"

src_prepare(){
	sed -i -e "/OnlyShowIn/d" "${MY_PN}.desktop"
	default
}

src_install(){
	mkdir -p "${ED%/}"/opt/${MY_PN}
	cp -r . "${ED%/}"/opt/${MY_PN}
	rm "${ED%/}"/opt/${MY_PN}/${MY_PN}.desktop
	domenu ${MY_PN}.desktop
	local size
	for size in 16 32 48 128 256; do
		doicon --size "${size}" Icon/${size}x${size}/${PN}.png
	done
	dosym /opt/${MY_PN}/${MY_PN} /usr/bin/smerge
}

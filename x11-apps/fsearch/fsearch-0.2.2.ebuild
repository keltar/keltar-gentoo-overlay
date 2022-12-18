# Copyright 1999-2022 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit xdg meson

DESCRIPTION="A fast file search utility for Unix-like systems based on GTK+3"
HOMEPAGE="http://www.fsearch.org/"
LICENSE="GPL-2+"

if [[ ${PV} == 9999 ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/cboxdoerfer/fsearch"
else
	MY_PV="${PV%%_*}beta2"
	SRC_URI="https://github.com/cboxdoerfer/fsearch/archive/${PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64 ~x86"
	S="${WORKDIR}/${PN}-${PV}"
fi

SLOT="0"
IUSE=""

RDEPEND="
	>=x11-libs/gtk+-3.18:3
	>=dev-libs/glib-2.50:2
	dev-libs/libpcre"

DEPEND="${RDEPEND}
	sys-devel/gettext
	virtual/pkgconfig
"

src_configure() {
	meson_src_configure
}

pkg_postinst() {
	xdg_desktop_database_update
	xdg_icon_cache_update
}

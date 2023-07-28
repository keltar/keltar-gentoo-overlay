# Copyright 2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit linux-mod-r1

DESCRIPTION="RTS5139 USB MMC card reader driver"
HOMEPAGE="https://github.com/asymingt/rts5139"

if [[ ${PV} == 9999 ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/asymingt/${PN}.git"
fi

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64"

DEPEND="virtual/linux-sources"
RDEPEND="${DEPEND}"
BDEPEND=""

src_compile() {
	local modlist=(rts5139=rts5139)
	local modargs=(KVER="${KV_FULL}")

	linux-mod-r1_src_compile
}

src_install() {
	linux-mod-r1_src_install
}

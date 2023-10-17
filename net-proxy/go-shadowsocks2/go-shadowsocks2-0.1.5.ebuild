# Copyright 2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit go-module

DESCRIPTION="Modern Shadowsocks in Go"
HOMEPAGE="https://github.com/shadowsocks/go-shadowsocks2"
SRC_URI="https://github.com/shadowsocks/${PN}/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64"

DEPEND=""
RDEPEND="${DEPEND}"
BDEPEND=""

src_unpack() {
	default
	tar xJf "${FILESDIR}/${P}-deps.tar.xz"
}

src_install() {
	mv bin/shadowsocks2-linux bin/go-shadowsocks2
	dobin bin/go-shadowsocks2
	newinitd "${FILESDIR}/go-shadowsocks2.initd" go-shadowsocks2
	newconfd "${FILESDIR}/go-shadowsocks2.confd" go-shadowsocks2
}

pkg_setup() {
	elog "To enable go-shadowsocks autostart, run"
	elog "  rc-update add go-shadowsocks2 default"
}

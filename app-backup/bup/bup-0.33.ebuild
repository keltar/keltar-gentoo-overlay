# Copyright 2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{7..11} )

inherit python-single-r1

DESCRIPTION="A highly efficient backup system based on the git packfile format"
HOMEPAGE="https://bup.github.io/ https://github.com/bup/bup"
SRC_URI="https://github.com/bup/bup/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="LGPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="+doc web"
REQUIRED_USE="${PYTHON_REQUIRED_USE}"

RDEPEND="${PYTHON_DEPS}
	app-arch/par2cmdline
	sys-libs/readline:0
	dev-vcs/git
	sys-apps/acl
	$(python_gen_cond_dep '
		dev-python/fuse-python[${PYTHON_USEDEP}]
		dev-python/pyxattr[${PYTHON_USEDEP}]
		web? ( dev-python/tornado[${PYTHON_USEDEP}] )
	')"
DEPEND="${RDEPEND}
	doc? ( app-text/pandoc )
"

src_configure() {
	# only build/install docs if enabled
	export PANDOC=$(usex doc pandoc "")

	emake || die
}

src_install() {
	emake DESTDIR="${D}" PREFIX=/usr DOCDIR="/usr/share/${PF}" \
		SITEDIR="$(python_get_sitedir)" install
	python_optimize
}

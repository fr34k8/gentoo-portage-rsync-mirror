# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/python3-openid/python3-openid-3.0.4_p1.ebuild,v 1.1 2014/08/30 14:06:40 maksbotan Exp $

EAPI=5

PYTHON_COMPAT=( python{3_2,3_3,3_4} )

inherit vcs-snapshot distutils-r1

DESCRIPTION="Python 3 port of the python-openid library"
HOMEPAGE="https://github.com/necaris/python3-openid https://pypi.python.org/pypi/python3-openid"
SRC_URI="https://github.com/necaris/${PN}/archive/47a15d30b962a4316473ae9909b3405773d78181.tar.gz -> ${P}.tar.gz"
#https://github.com/necaris/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64"
IUSE="examples test"

DEPEND=""
RDEPEND="${DEPEND}"

PATCHES=(
	"${FILESDIR}"/django-tests.patch
)

python_test() {
	"${S}"/run_tests.sh || die "tests fail on ${EPYTHON}"
}

python_install_all() {
	use examples && local EXAMPLES="examples/."
	distutils-r1_python_install_all
}

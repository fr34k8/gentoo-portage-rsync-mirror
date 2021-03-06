# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-themes/pulse-glass/pulse-glass-20100616.ebuild,v 1.3 2010/06/17 17:18:37 spatz Exp $

MY_PN="Pulse-Glass"

DESCRIPTION="The Pulse Glass x11 mouse cursor theme"
HOMEPAGE="http://kde-look.org/content/show.php/Pulse+Glass?content=124442"
SRC_URI="http://kde-look.org/CONTENT/content-files/124442-${MY_PN}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

S="${WORKDIR}/${MY_PN}"

src_install() {
	insinto /usr/share/cursors/xorg-x11/${MY_PN}
	doins -r cursors || die
}

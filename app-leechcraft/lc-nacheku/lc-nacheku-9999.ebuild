# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-leechcraft/lc-nacheku/lc-nacheku-9999.ebuild,v 1.1 2013/05/02 14:20:35 pinkbyte Exp $

EAPI="5"

inherit leechcraft

DESCRIPTION="Monitors selected directory and clipboard for downloadable entities"

SLOT="0"
KEYWORDS=""
IUSE="debug"

DEPEND="~app-leechcraft/lc-core-${PV}"
RDEPEND="${DEPEND}"

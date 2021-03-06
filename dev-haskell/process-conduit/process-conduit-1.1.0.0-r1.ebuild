# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-haskell/process-conduit/process-conduit-1.1.0.0-r1.ebuild,v 1.1 2014/07/02 12:23:07 gienah Exp $

EAPI=5

# ebuild generated by hackport 0.3.6.9999

CABAL_FEATURES="lib profile haddock hoogle hscolour test-suite"
inherit base haskell-cabal

DESCRIPTION="Conduits for processes"
HOMEPAGE="http://github.com/tanakh/process-conduit"
SRC_URI="mirror://hackage/packages/archive/${PN}/${PV}/${P}.tar.gz"

LICENSE="BSD"
SLOT="0/${PV}"
KEYWORDS="~amd64 ~x86"
IUSE=""

PATCHES=("${FILESDIR}/${PN}-1.1.0.0-conduit-1.1.patch")

RDEPEND=">=dev-haskell/conduit-1.1:=[profile?]
	>=dev-haskell/control-monad-loop-0.1:=[profile?] <dev-haskell/control-monad-loop-0.2:=[profile?]
	>=dev-haskell/mtl-2.0:=[profile?]
	>=dev-haskell/resourcet-1.1:=[profile?]
	dev-haskell/shakespeare:=[profile?]
	>=dev-haskell/shakespeare-text-1.0:=[profile?]
	>=dev-haskell/text-0.11:=[profile?]
	>=dev-lang/ghc-6.12.1:=
"
DEPEND="${RDEPEND}
	>=dev-haskell/cabal-1.8.0.2
	test? ( >=dev-haskell/hspec-1.3 )
"

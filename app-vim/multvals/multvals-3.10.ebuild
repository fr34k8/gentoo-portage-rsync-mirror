# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-vim/multvals/multvals-3.10.ebuild,v 1.7 2010/10/07 03:25:42 leio Exp $

inherit vim-plugin

DESCRIPTION="vim plugin: library for helping with arrays"
HOMEPAGE="http://www.vim.org/scripts/script.php?script_id=171"
LICENSE="GPL-2"
KEYWORDS="alpha amd64 ia64 ~mips ppc sparc x86"
IUSE=""

RDEPEND="|| ( >=app-editors/vim-6.3 >=app-editors/gvim-6.3 )"

VIM_PLUGIN_HELPTEXT=\
"This plugin provides library functions and is not intended to be used
directly by the user."

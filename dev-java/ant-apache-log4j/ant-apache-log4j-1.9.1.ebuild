# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/ant-apache-log4j/ant-apache-log4j-1.9.1.ebuild,v 1.1 2013/07/05 11:12:19 tomwij Exp $

EAPI="5"

ANT_TASK_DEPNAME="log4j"

inherit ant-tasks

KEYWORDS="~amd64 ~ppc ~ppc64 ~x86 ~x86-fbsd ~x64-freebsd ~x86-freebsd \
	~amd64-linux ~x86-linux ~ppc-macos ~x64-macos ~x86-macos ~sparc-solaris \
	~sparc64-solaris ~x64-solaris ~x86-solaris"

DEPEND=">=dev-java/log4j-1.2.13-r2:0"
RDEPEND="${DEPEND}"

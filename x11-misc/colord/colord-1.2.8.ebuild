# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/colord/colord-1.2.8.ebuild,v 1.2 2015/02/03 11:58:04 pacho Exp $

EAPI="5"
GCONF_DEBUG="no"
GNOME2_LA_PUNT="yes"
VALA_USE_DEPEND="vapigen"
VALA_MIN_API_VERSION="0.18"

inherit autotools bash-completion-r1 check-reqs eutils gnome2 multilib-minimal user systemd udev vala

DESCRIPTION="System service to accurately color manage input and output devices"
HOMEPAGE="http://www.freedesktop.org/software/colord/"
SRC_URI="http://www.freedesktop.org/software/colord/releases/${P}.tar.xz"

LICENSE="GPL-2+"
SLOT="0/2" # subslot = libcolord soname version
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~mips ~ppc ~ppc64 ~sparc ~x86 ~x86-fbsd"

# We prefer policykit enabled by default, bug #448058
IUSE="argyllcms examples extra-print-profiles +gusb +introspection +policykit scanner systemd +udev vala"
REQUIRED_USE="
	gusb? ( udev )
	scanner? ( udev )
	vala? ( introspection )
"

COMMON_DEPEND="
	dev-db/sqlite:3=
	>=dev-libs/glib-2.36:2[${MULTILIB_USEDEP}]
	>=media-libs/lcms-2.6:2=[${MULTILIB_USEDEP}]
	argyllcms? ( media-gfx/argyllcms )
	gusb? ( >=dev-libs/libgusb-0.2.2[introspection?,${MULTILIB_USEDEP}] )
	introspection? ( >=dev-libs/gobject-introspection-0.9.8 )
	policykit? ( >=sys-auth/polkit-0.103 )
	scanner? (
		media-gfx/sane-backends
		sys-apps/dbus )
	systemd? ( >=sys-apps/systemd-44:0= )
	udev? (
		virtual/udev
		virtual/libgudev:=
		virtual/libudev:=[${MULTILIB_USEDEP}]
	)
"
RDEPEND="${COMMON_DEPEND}
	!media-gfx/shared-color-profiles
	!<=media-gfx/colorhug-client-0.1.13
"
DEPEND="${COMMON_DEPEND}
	dev-libs/libxslt
	>=dev-util/gtk-doc-am-1.9
	>=dev-util/intltool-0.35
	>=sys-devel/gettext-0.17
	virtual/pkgconfig[${MULTILIB_USEDEP}]
	extra-print-profiles? ( media-gfx/argyllcms )
	vala? ( $(vala_depend) )
"

# FIXME: needs pre-installed dbus service files
RESTRICT="test"

# According to upstream comment in colord.spec.in, building the extra print
# profiles requires >=4G of memory
CHECKREQS_MEMORY="4G"

pkg_pretend() {
	use extra-print-profiles && check-reqs_pkg_pretend
}

pkg_setup() {
	use extra-print-profiles && check-reqs_pkg_setup
	enewgroup colord
	enewuser colord -1 -1 /var/lib/colord colord
}

src_prepare() {
	# Adapt to Gentoo paths
	sed -i -e 's/spotread/argyll-spotread/' \
		src/sensors/cd-sensor-argyll.c \
		configure.ac || die

	eautoreconf
	use vala && vala_src_prepare
	gnome2_src_prepare
}

multilib_src_configure() {
	# Reverse tools require gusb
	# bash-completion test does not work on gentoo
	local myconf=(
		--disable-bash-completion
		--disable-examples
		--disable-static
		--enable-libcolordcompat
		--with-daemon-user=colord
		--localstatedir="${EPREFIX}"/var
		$(multilib_native_use_enable argyllcms argyllcms-sensor)
		$(multilib_native_use_enable extra-print-profiles print-profiles)
		$(multilib_native_usex extra-print-profiles COLPROF="$(type -P argyll-colprof)" "")
		$(use_enable gusb)
		$(multilib_native_use_enable gusb reverse)
		$(multilib_native_use_enable introspection)
		$(multilib_native_use_enable policykit polkit)
		$(multilib_native_use_enable scanner sane)
		$(multilib_native_use_enable systemd systemd-login)
		$(use_enable udev)
		--with-udevrulesdir="$(get_udevdir)"/rules.d
		$(multilib_native_use_enable vala)
		"$(systemd_with_unitdir)"
	)

	if ! multilib_is_native_abi; then
		# disable some extraneous checks
		myconf+=(
			SQLITE_{CFLAGS,LIBS}=' '
			GUDEV_{CFLAGS,LIBS}=' '
		)
	fi

	ECONF_SOURCE=${S} \
	gnome2_src_configure "${myconf[@]}"
}

multilib_src_compile() {
	if multilib_is_native_abi; then
		gnome2_src_compile
	else
		emake -C lib/colord
		emake -C lib/colorhug
		emake -C lib/compat
	fi
}

multilib_src_test() {
	if multilib_is_native_abi; then
		default
	else
		emake -C lib/colord check
		emake -C lib/colorhug check
		emake -C lib/compat check
	fi
}

multilib_src_install() {
	if multilib_is_native_abi; then
		gnome2_src_install
	else
		gnome2_src_install -C lib/colord
		gnome2_src_install -C lib/colorhug
		gnome2_src_install -C lib/compat
		gnome2_src_install -C contrib/session-helper install-libcolord_includeHEADERS
	fi
}

multilib_src_install_all() {
	DOCS="AUTHORS ChangeLog MAINTAINERS NEWS README.md TODO"
	einstalldocs

	newbashcomp data/colormgr colormgr

	# Ensure config and profile directories exist and /var/lib/colord/*
	# is writable by colord user
	keepdir /var/lib/color{,d}/icc
	fowners colord:colord /var/lib/colord{,/icc}

	if use examples; then
		docinto examples
		dodoc examples/*.c
	fi
}

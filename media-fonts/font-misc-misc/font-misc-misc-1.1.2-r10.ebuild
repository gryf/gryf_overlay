# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-fonts/font-misc-misc/font-misc-misc-1.1.2.ebuild,v 1.10 2011/02/14 13:26:18 xarthisius Exp $

EAPI=3
inherit xorg-2

DESCRIPTION="X.Org miscellaneous fonts"

KEYWORDS="alpha amd64 arm ~arm64 hppa ia64 ~mips ppc ppc64 s390 sh sparc x86 ~amd64-fbsd ~x86-fbsd ~x86-interix ~amd64-linux ~arm-linux ~x86-linux ~ppc-macos ~x64-macos ~x86-macos ~sparc-solaris ~x64-solaris ~x86-solaris"
IUSE="-slashed-zero"

RDEPEND=""
DEPEND="${RDEPEND}
	x11-apps/bdftopcf"

src_prepare() {
	if use slashed-zero; then
		epatch "${FILESDIR}/slashed-zero.patch"
	fi
}

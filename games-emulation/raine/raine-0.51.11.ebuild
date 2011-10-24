# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-emulation/raine/raine-0.51.9.ebuild,v 1.4 2011/06/16 10:11:03 tupone Exp $

EAPI=2
inherit flag-o-matic eutils games

DESCRIPTION="R A I N E  M680x0 Arcade Emulation"
HOMEPAGE="http://rainemu.swishparty.co.uk/"
echo ${PV}
SRC_URI="http://rainemu.swishparty.co.uk/html/archive/raines-${PV}.tar.bz2"

LICENSE="Artistic"
SLOT="0"
KEYWORDS="x86"
IUSE=""

RDEPEND="dev-cpp/muParser
	media-libs/libsdl[audio,joystick,video]
	sys-libs/zlib
	media-libs/sdl-image[png]
	media-libs/sdl-ttf"
DEPEND="${RDEPEND}
	dev-lang/nasm
	app-arch/unzip"

src_prepare() {
	echo > detect-cpu
	echo > cpuinfo
	sed -i \
		-e "/^NEO/s:^:#:" \
		-e "s:nasmw:nasm:" \
		-e "/bindir/s:=.*:=\$(DESTDIR)${GAMES_BINDIR}:" \
		-e "/sharedir =/s:=.*:=\$(DESTDIR)${GAMES_DATADIR}:" \
		-e "/mandir/s:=.*:=\$(DESTDIR)/usr/share/man/man6:" \
		makefile \
		|| die "sed failed"
	epatch "${FILESDIR}"/${P}-ldflags.patch \
		"${FILESDIR}"/${P}-libpng1.5.patch \
		"${FILESDIR}"/${P}-install_path.patch
	append-ldflags -Wl,-z,noexecstack
}

src_compile() {
	local myopts

	emake \
		_MARCH="${CFLAGS}" \
		VERBOSE=1 \
		${myopts} || die "emake failed"
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
	keepdir "${GAMES_DATADIR}"/${PN}/{roms,artwork,emudx,scripts/raine}
	dodoc docs/readme.txt
	prepgamesdirs
}

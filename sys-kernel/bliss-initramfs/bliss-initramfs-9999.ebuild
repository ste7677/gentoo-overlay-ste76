# Copyright 1999-2019 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python{3_6,3_7,3_8,3_9} )
inherit python-single-r1 git-r3

GITHUB_USER="ste7677"
GITHUB_REPO="bliss-initramfs"
GITHUB_TAG="${PV}"

DESCRIPTION="Boot your system's rootfs from ZFS, LVM, RAID, or a variety of other configs."
HOMEPAGE="https://github.com/${GITHUB_USER}/${GITHUB_REPO}"
EGIT_REPO_URI="https://github.com/${GITHUB_USER}/${GITHUB_REPO}.git"

REQUIRED_USE="${PYTHON_REQUIRED_USE}"
RESTRICT="mirror"
LICENSE="BSD-2"
SLOT="0"
KEYWORDS="-* amd64"

RDEPEND="
	${PYTHON_DEPS}
	app-arch/cpio
	virtual/udev"

src_install() {
	# Copy the main executable
	local executable="mkinitrd.py"
	exeinto "/opt/${PN}"
	doexe "${executable}"

	# Copy the libraries required by this executable
	cp -r "${S}/files" "${D}/opt/${PN}" || die
	cp -r "${S}/pkg" "${D}/opt/${PN}" || die

	# Copy documentation files
	dodoc README.md USAGE

	# Make a symbolic link: /sbin/bliss-initramfs
	dosym "${EPREFIX}/opt/${PN}/${executable}" "/sbin/${PN}"
}

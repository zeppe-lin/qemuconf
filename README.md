OVERVIEW

	This directory contains qemuconf, a tiny utility that executes qemu(1)
	with arguments from a configuration file.

	This qemuconf distribution is a fork of Gottox' qemuconf version
	0.2.1, commit 50b8369 (Thu Nov 17 2022) with the following little
	differences:

		* the man page have been rewritten
		* added qemuconf-import(1) man page
		* removed unnecessary service files
		* tests and qemuconf-import(1) was adjusted to POSIX sh(1p)

	See git log for complete/further differences.

	The original sources can be downloaded from:
	1. https://github.com/Gottox/qemuconf
	2. https://github.com/Gottox/qemuconf/archive/50b8369/qemuconf-50b8369.zip

REQUIREMENTS

	Build time:

		* c99 compiler
		* POSIX sh(1p), make(1p) and "mandatory utilities"

	Tests:

		* POSIX sh(1p), make(1p) and "mandatory utilities"

INSTALL

	The shell commands "make && make install" should build and install
	this package.  See config.mk file for configuration parameters.

	The shell command "make check" should start some tests.

LICENSE

	qemuconf is licensed through MIT License.
	See LICENSE file for copyright and license details.

End of file.

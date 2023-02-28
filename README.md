ABOUT
-----
This directory contains _qemuconf_, a tiny utility that executes
**qemu(1)** with arguments from a configuration file.

This _qemuconf_ distribution is a fork of Gottox' _qemuconf_ version
0.2.1, commit 50b8369 (Thu Nov 17 2022) with the following little
differences:
  * the man page have been completely rewritten
  * added qemuconf-import(1) man page
  * removed unnecessary service files
  * test file was adjusted to POSIX sh(1p)
  * qemuconf-import was adjusted to POSIX sh(1p)

See git log for complete/further differences.

The original sources can be downloaded from:
  1. https://github.com/Gottox/qemuconf
  2. https://github.com/Gottox/qemuconf/archive/50b8369/qemuconf-50b8369.zip

REQUIREMENTS
------------
Build time:
  * c99 compiler
  * POSIX sh(1p), make(1p) and "mandatory utilities"

Tests:
  * POSIX sh(1p), make(1p) and "mandatory utilities"

INSTALL
-------
The shell commands `make && make install` should build and install
this package.  See _config.mk_ file for configuration parameters.

The shell command `make check` should start some tests.

LICENSE
-------
_qemuconf_ is licensed through MIT License.
See _LICENSE_ file for copyright and license details.

<!-- vim:sw=2:ts=2:sts=2:et:cc=72:tw=70
End of file. -->

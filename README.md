OVERVIEW
========

This repository contains `qemuconf`, a tiny utility that executes
`qemu(1)` with arguments from a configuration file.

This `qemuconf` distribution is a fork of Gottox' `qemuconf` version
0.2.1, commit 50b8369 (Thu Nov 17 2022) with the following little
differences:
  * `qemuconf(1)` manual page in `mdoc(7)` format
  * `qemuconf-import(1)` manual page
  * remove unnecessary service files
  * long cmdline options
  * cmdline `-q/--qemubin` option overrides config setting
  * POSIX `sh(1p)` for tests and `qemuconf-import`

See git log for complete/further differences.

The original sources can be downloaded from:
  1. https://github.com/Gottox/qemuconf
  2. https://github.com/Gottox/qemuconf/archive/50b8369/qemuconf-50b8369.zip


REQUIREMENTS
============

Build time
----------
  * C99 compiler
  * POSIX `sh(1p)`, `make(1p)` and "mandatory utilities"

Tests
-----
  * POSIX `sh(1p)`, `make(1p)` and "mandatory utilities"


INSTALL
=======

The shell commands `make && make install` should build and install
this package.

The shell command `make check` should start some tests.

See `config.mk` file for configuration parameters.


DOCUMENTATION
=============

Online documentation
--------------------

Manual pages:
- [qemuconf-import.1](https://zeppe-lin.github.io/qemuconf-import.1.html)
- [qemuconf.1](https://zeppe-lin.github.io/qemuconf.1.html)


LICENSE
=======

`qemuconf` is licensed through MIT License.
See LICENSE file for copyright and license details.

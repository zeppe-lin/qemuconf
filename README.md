OVERVIEW
========

`qemuconf` is a small utility that runs `qemu(1)` with arguments
provided from a configuration file.

This distribution is a fork of Gottox's `qemuconf` version 0.2.1
(commit 50b8369, Thu Nov 17 2022), with the following differences:
  * Manual page for `qemuconf(1)` in `scdoc(5)` format
  * Renamed `qemuconf-import` to `qemuconf-mkconfig`
  * Added manual page for `qemuconf-mkconfig(1)`
  * Remove unnecessary service files
  * Added long command-line options
  * `-q`/`--qemubin` options override config setting
  * POSIX `sh(1p)` used for tests and `qemuconf-mkconfig`

See the git log for full history.

Original sources:
  1. https://github.com/Gottox/qemuconf
  2. https://github.com/Gottox/qemuconf/archive/50b8369/qemuconf-50b8369.zip

---

REQUIREMENTS
============

Build-time
----------
  * C99 compiler
  * POSIX `sh(1p)`, `make(1p)`, and "mandatory utilities"
  * `scdoc(1)` to generate manual pages

Tests
-----
  * POSIX `sh(1p)`, `make(1p)`, and "mandatory utilities"

---

INSTALLATION
============

To build and install:

```sh
make
make install   # as root
```

To run tests:

```sh
make check
```

Configuration parameters are defined in `config.mk`.

---

DOCUMENTATION
=============

Manual pages are provided in `/man` and installed under the system
manual hierarchy.

---

LICENSE
=======

`qemuconf` is licensed under the MIT License.

See `LICENSE` file for copyright and license details.

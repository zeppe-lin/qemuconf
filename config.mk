# This file is a part of qemuconf.
# See COPYING and COPYRIGHT files for corresponding information.

# qemuconf version
VERSION = 0.2.1

# qemu default binary
BINARY = qemu-system-x86_64

# paths
PREFIX = /usr/local
BINDIR = ${PREFIX}/bin
MANDIR = ${PREFIX}/share/man

# flags
CPPFLAGS = -DVERSION=\"${VERSION}\" -DBINARY=\"${BINARY}\"
CFLAGS   = -Wall -Wextra -pedantic
LDFLAGS  =

# compiler and linker
CC = gcc
LD = ${CC}

# vim:cc=72:tw=70
# End of file.
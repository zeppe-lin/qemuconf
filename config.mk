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

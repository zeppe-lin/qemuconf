# qemuconf version
VERSION = 0.3

# qemu default binary
BINARY = qemu-system-x86_64

# paths
PREFIX    = /usr/local
MANPREFIX = ${PREFIX}/share/man

# flags
CPPFLAGS = -DVERSION=\"${VERSION}\" -DBINARY=\"${BINARY}\"
CFLAGS   = -pedantic -Wall -Wextra -Wformat
LDFLAGS  =

# compiler and linker
CC = cc
LD = ${CC}

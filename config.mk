# project metadata
NAME       = qemuconf
VERSION    = 0.4.2
DIST       = ${NAME}-${VERSION}

# qemu default binary
QEMU_BIN   = qemu-system-x86_64

# paths
PREFIX     = /usr/local
MANPREFIX  = ${PREFIX}/share/man

# flags
CPPFLAGS   = -DNAME=\"${NAME}\" -DVERSION=\"${VERSION}\" \
	     -DQEMU_BIN=\"${QEMU_BIN}\"
CFLAGS     = -pedantic -Wall -Wextra -Wformat
LDFLAGS    =

# compiler and linker
CC         = cc
LD         = ${CC}

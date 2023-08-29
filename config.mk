# project metadata
NAME       = qemuconf
VERSION    = 0.4.3z
DIST       = ${NAME}-${VERSION}

# qemu default binary
QEMU_BIN   = qemu-system-x86_64

# paths
PREFIX     = /usr/local
MANPREFIX  = ${PREFIX}/share/man

# flags
CFLAGS     = -pedantic -Wall -Wextra -Wformat -D_DEFAULT_SOURCE \
	     -DVERSION=\"${VERSION}\" -DQEMU_BIN=\"${QEMU_BIN}\"
LDFLAGS    =

# project metadata
NAME      = qemuconf
VERSION   = 0.5

# qemu default binary
QEMU_BIN  = qemu-system-x86_64

# paths
PREFIX    = /usr/local
MANPREFIX = ${PREFIX}/share/man

# flags
CPPFLAGS  = -D_DEFAULT_SOURCE -DVERSION=\"${VERSION}\" \
            -DQEMU_BIN=\"${QEMU_BIN}\"
CFLAGS    = -pedantic -Wall -Wextra -Wformat ${CPPFLAGS}
LDFLAGS   =

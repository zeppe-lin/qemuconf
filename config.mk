# project metadata
NAME       = qemuconf
VERSION    = 0.4.2
DIST       = ${NAME}-${VERSION}

# qemu default binary
BINARY     = qemu-system-x86_64

# paths
PREFIX     = /usr/local
MANPREFIX  = ${PREFIX}/share/man

# flags
CPPFLAGS   = -DNAME=\"${NAME}\" -DVERSION=\"${VERSION}\" \
	     -DBINARY=\"${BINARY}\"
CFLAGS     = -pedantic -Wall -Wextra -Wformat
LDFLAGS    =

# compiler and linker
CC         = cc
LD         = ${CC}

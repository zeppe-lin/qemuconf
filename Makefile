.POSIX:

include config.mk

all: qemuconf

.c.o:
	${CC} -c ${CFLAGS} ${CPPFLAGS} $<

qemuconf: qemuconf.o
	${LD} qemuconf.o ${LDFLAGS} -o $@

check: qemuconf
	@echo "=======> Check qemuconf parsing for errors"
	@tests/run.sh

install: all
	mkdir -p ${DESTDIR}${PREFIX}/bin
	mkdir -p ${DESTDIR}${MANPREFIX}/man1
	cp -f qemuconf ${DESTDIR}${PREFIX}/bin/
	cp -f qemuconf-import ${DESTDIR}${MANPREFIX}/man1/
	sed "s/@VERSION@/${VERSION}/g" qemuconf.1.in > \
		${DESTDIR}${MANPREFIX}/man1/qemuconf.1
	sed "s/@VERSION@/${VERSION}/g" qemuconf-import.1.in > \
		${DESTDIR}${MANPREFIX}/man1/qemuconf-import.1

uninstall:
	cd ${DESTDIR}${PREFIX}/bin     && rm -f qemuconf   qemuconf-import
	cd ${DESTDIR}${MANPREFIX}/man1 && rm -f qemuconf.1 qemuconf-import.1

clean:
	rm -f qemuconf qemuconf.o qemuconf.1 qemuconf-import.1

.PHONY: all install uninstall check clean

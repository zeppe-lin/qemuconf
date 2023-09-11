.POSIX:

include config.mk

all: qemuconf

check: qemuconf
	@echo "=======> Check qemuconf parsing for errors"
	@tests/run.sh

install: all
	mkdir -p ${DESTDIR}${PREFIX}/bin
	mkdir -p ${DESTDIR}${MANPREFIX}/man1
	cp -f qemuconf ${DESTDIR}${PREFIX}/bin/
	cp -f qemuconf-import ${DESTDIR}${PREFIX}/bin/
	cp -f qemuconf.1 ${DESTDIR}${MANPREFIX}/man1/
	cp -f qemuconf-import.1 ${DESTDIR}${MANPREFIX}/man1/
	chmod 0755 ${DESTDIR}${PREFIX}/bin/qemuconf
	chmod 0755 ${DESTDIR}${PREFIX}/bin/qemuconf-import
	chmod 0644 ${DESTDIR}${MANPREFIX}/man1/qemuconf.1
	chmod 0644 ${DESTDIR}${MANPREFIX}/man1/qemuconf-import.1

uninstall:
	rm -f ${DESTDIR}${PREFIX}/bin/qemuconf
	rm -f ${DESTDIR}${PREFIX}/bin/qemuconf-import
	rm -f ${DESTDIR}${MANPREFIX}/man1/qemuconf.1
	rm -f ${DESTDIR}${MANPREFIX}/man1/qemuconf-import.1

clean:
	rm -f qemuconf
	rm -f ${DIST}.tar.gz

dist: clean
	git archive --format=tar.gz -o ${DIST}.tar.gz --prefix=${DIST}/ HEAD

.PHONY: all check install uninstall clean dist

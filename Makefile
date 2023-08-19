.POSIX:

include config.mk

all: qemuconf

.c.o:
	${CC} -c ${CFLAGS} ${CPPFLAGS} $<

qemuconf: qemuconf.o

check: qemuconf
	@echo "=======> Check qemuconf parsing for errors"
	@tests/run.sh

install: all
	mkdir -p ${DESTDIR}${PREFIX}/bin
	mkdir -p ${DESTDIR}${MANPREFIX}/man1
	cp -f qemuconf ${DESTDIR}${PREFIX}/bin/
	cp -f qemuconf-import ${DESTDIR}${PREFIX}/bin/
	sed "s/@VERSION@/${VERSION}/g" qemuconf.1 \
		> ${DESTDIR}${MANPREFIX}/man1/qemuconf.1
	sed "s/@VERSION@/${VERSION}/g" qemuconf-import.1 \
		> ${DESTDIR}${MANPREFIX}/man1/qemuconf-import.1
	cd ${DESTDIR}${PREFIX}/bin     && chmod 0755 qemuconf   qemuconf-import
	cd ${DESTDIR}${MANPREFIX}/man1 && chmod 0644 qemuconf.1 qemuconf-import.1

uninstall:
	cd ${DESTDIR}${PREFIX}/bin     && rm -f qemuconf   qemuconf-import
	cd ${DESTDIR}${MANPREFIX}/man1 && rm -f qemuconf.1 qemuconf-import.1

clean:
	rm -f qemuconf *.o
	rm -f ${DIST}.tar.gz

dist: clean
	git archive --format=tar.gz -o ${DIST}.tar.gz --prefix=${DIST}/ HEAD

.PHONY: all check install uninstall clean dist

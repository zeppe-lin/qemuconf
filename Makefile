# See LICENSE file for copyright and license details.

include config.mk

all: qemuconf qemuconf.1 qemuconf-import.1

%: %.pod
	pod2man --nourls -c ' ' -r ${VERSION} -s 1 \
		-n $(basename $@) $< > $@

.c.o:
	${CC} -c ${CFLAGS} ${CPPFLAGS} $<

qemuconf: qemuconf.o
	${LD} -o $@ ${LDFLAGS} $^

install: all
	mkdir -p ${DESTDIR}${BINDIR} ${DESTDIR}${MANDIR}/man1
	cp -f qemuconf   qemuconf-import   ${DESTDIR}${BINDIR}/
	chmod 0755 ${DESTDIR}${BINDIR}/*
	cp -f qemuconf.1 qemuconf-import.1 ${DESTDIR}${MANDIR}/man1/
	chmod 0644 ${DESTDIR}${MANDIR}/man1/*

uninstall:
	rm -f ${DESTDIR}${BINDIR}/qemuconf
	rm -f ${DESTDIR}${BINDIR}/qemuconf-import
	rm -f ${DESTDIR}${MANDIR}/man1/qemuconf.1
	rm -f ${DESTDIR}${MANDIR}/man1/qemuconf-import.1

check: qemuconf
	tests/run.sh

clean:
	rm -f qemuconf qemuconf.o qemuconf.1 qemuconf-import.1

.PHONY: all install uninstall check clean

# vim:cc=72:tw=70
# End of file.

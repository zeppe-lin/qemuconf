# This file is a part of qemuconf.
# See COPYING and COPYRIGHT files for corresponding information.

include config.mk

all: qemuconf qemuconf.1 qemuconf-import.1

%: %.pod
	pod2man --nourls -r ${VERSION} -c ' ' -n $(basename $@) \
		-s 1 $< > $@

.c.o:
	${CC} -c ${CFLAGS} ${CPPFLAGS} $< -o $@

qemuconf: qemuconf.o
	${LD} $^ ${LDFLAGS} -o $@

install: all
	install -m 0755 -Dt ${DESTDIR}${BINDIR}/ \
		qemuconf qemuconf-import
	install -m 0644 -Dt ${DESTDIR}${MANDIR}/man1/ \
		qemuconf.1 qemuconf-import.1

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

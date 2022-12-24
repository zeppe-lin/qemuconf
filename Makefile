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
	mkdir -p ${DESTDIR}${PREFIX}/bin
	mkdir -p ${DESTDIR}${MANPREFIX}/man1
	cp -f qemuconf   qemuconf-import   ${DESTDIR}${PREFIX}/sbin/
	cp -f qemuconf.1 qemuconf-import.1 ${DESTDIR}${MANPREFIX}/man1/

uninstall:
	cd ${DESTDIR}${PREFIX}/bin     && rm -f qemuconf   qemuconf-import
	cd ${DESTDIR}${MANPREFIX}/man1 && rm -f qemuconf.1 qemuconf-import.1

check: qemuconf
	tests/run.sh

clean:
	rm -f qemuconf qemuconf.o qemuconf.1 qemuconf-import.1

.PHONY: all install uninstall check clean

# vim:cc=72:tw=70
# End of file.

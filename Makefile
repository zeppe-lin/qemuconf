.POSIX:

include config.mk

all: qemuconf qemuconf.1 qemuconf-import.1

%: %.pod
	pod2man --nourls -r ${VERSION} -c ' ' -s 1 \
		-n $(basename $@) $< > $@

.c.o:
	${CC} -c ${CFLAGS} ${CPPFLAGS} $<

qemuconf: qemuconf.o
	${LD} $^ ${LDFLAGS} -o $@

check: qemuconf
	@echo "=======> Check PODs for errors"
	@podchecker *.pod
	@echo "=======> Check URLs for response code"
	@grep -Eiho "https?://[^\"\\'> ]+" *.* | xargs -P10 -I{} \
		curl -o /dev/null -sw "[%{http_code}] %{url}\n" '{}'
	@echo "=======> Check qemuconf parsing for errors"
	@tests/run.sh

install: all
	mkdir -p ${DESTDIR}${PREFIX}/bin
	mkdir -p ${DESTDIR}${MANPREFIX}/man1
	cp -f qemuconf   qemuconf-import   ${DESTDIR}${PREFIX}/bin/
	cp -f qemuconf.1 qemuconf-import.1 ${DESTDIR}${MANPREFIX}/man1/

uninstall:
	cd ${DESTDIR}${PREFIX}/bin     && rm -f qemuconf   qemuconf-import
	cd ${DESTDIR}${MANPREFIX}/man1 && rm -f qemuconf.1 qemuconf-import.1

clean:
	rm -f qemuconf qemuconf.o qemuconf.1 qemuconf-import.1

.PHONY: all install uninstall check clean

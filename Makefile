.POSIX:

include config.mk

BIN1 = qemuconf   qemuconf-import
MAN1 = qemuconf.1 qemuconf-import.1

all: ${BIN1} ${MAN1}

%: %.in
	sed "s/@VERSION@/${VERSION}/g" $< > $@

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
	cp -f ${BIN1} ${DESTDIR}${PREFIX}/bin/
	cp -f ${MAN1} ${DESTDIR}${MANPREFIX}/man1/
	cd ${DESTDIR}${PREFIX}/bin     && rm -f ${BIN1}
	cd ${DESTDIR}${MANPREFIX}/man1 && rm -f ${MAN1}

uninstall:
	cd ${DESTDIR}${PREFIX}/bin     && rm -f ${BIN1}
	cd ${DESTDIR}${MANPREFIX}/man1 && rm -f ${MAN1}

clean:
	rm -f ${BIN1} qemuconf.o ${MAN1}

.PHONY: all check install uninstall clean

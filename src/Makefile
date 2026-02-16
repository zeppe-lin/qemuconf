.POSIX:

include ../config.mk

all: qemuconf qemuconf-mkconfig

qemuconf-mkconfig: qemuconf-mkconfig.in
	sed "s/@VERSION@/$(VERSION)/g" qemuconf-mkconfig.in > $@
	chmod 0755 $@

install: all
	mkdir -p $(DESTDIR)$(PREFIX)/bin
	cp -f qemuconf $(DESTDIR)$(PREFIX)/bin/
	cp -f qemuconf-mkconfig $(DESTDIR)$(PREFIX)/bin/
	chmod 0755 $(DESTDIR)$(PREFIX)/bin/qemuconf
	chmod 0755 $(DESTDIR)$(PREFIX)/bin/qemuconf-mkconfig

uninstall:
	rm -f $(DESTDIR)$(PREFIX)/bin/qemuconf
	rm -f $(DESTDIR)$(PREFIX)/bin/qemuconf-mkconfig

clean:
	rm -f qemuconf qemuconf-mkconfig

.PHONY: all install uninstall clean

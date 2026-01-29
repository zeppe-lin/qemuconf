.POSIX:

include ../config.mk

MAN1 = qemuconf.1 qemuconf-mkconfig.1

all: $(MAN1)

$(MAN1):
	scdoc < $@.scdoc > $@

install: all
	mkdir -p $(DESTDIR)$(MANPREFIX)/man1
	cp -f $(MAN1) $(DESTDIR)$(MANPREFIX)/man1

uninstall:
	cd $(DESTDIR)$(MANPREFIX)/man1 && rm -f $(MAN1)

clean:
	rm -f $(MAN1)

.PHONY: all install uninstall clean

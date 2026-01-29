.POSIX:

include config.mk

SUBDIRS = man src

all install uninstall clean:
	for subdir in $(SUBDIRS); do (cd $$subdir; $(MAKE) $@); done

check:
	(cd src; $(MAKE) all)
	@echo "=======> Check qemuconf parsing for errors"
	@tests/runner.sh

release:
	git tag -a v$(VERSION) -m v$(VERSION)

.PHONY: all install uninstall clean release

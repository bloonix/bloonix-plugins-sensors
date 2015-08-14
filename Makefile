CONFIG=Makefile.config

include $(CONFIG)

default: build

build:

	for file in \
		sudoers/check-lm-sensors \
	; do \
		cp $$file.in $$file; \
		sed -i "s!@@PREFIX@@!$(PREFIX)!g" $$file; \
	done;

install:
	if test ! -e "$(PREFIX)/lib/bloonix/plugins" ; then \
		mkdir -p $(PREFIX)/lib/bloonix/plugins; \
		chmod 755 $(PREFIX)/lib/bloonix/plugins; \
	fi;

	cd plugins; for file in check-* ; do \
		cp $$file $(PREFIX)/lib/bloonix/plugins/; \
		chmod 755 $(PREFIX)/lib/bloonix/plugins/$$file; \
	done;

	if test ! -e "$(PREFIX)/lib/bloonix/etc/plugins" ; then \
		mkdir -p $(PREFIX)/lib/bloonix/etc/plugins; \
		chmod 755 $(PREFIX)/lib/bloonix/etc/plugins; \
	fi;

	cd plugins; for file in plugin-* ; do \
		cp $$file $(PREFIX)/lib/bloonix/etc/plugins/; \
		chmod 644 $(PREFIX)/lib/bloonix/etc/plugins/$$file; \
	done;

	if test ! -e "$(PREFIX)/lib/bloonix/etc/sudoers.d" ; then \
		mkdir -p $(PREFIX)/lib/bloonix/etc/sudoers.d; \
		chmod 755 $(PREFIX)/lib/bloonix/etc/sudoers.d; \
	fi;

	if test ! -e "$(PREFIX)/lib/bloonix/etc/conf.d" ; then \
		mkdir -p $(PREFIX)/lib/bloonix/etc/conf.d; \
		chmod 755 $(PREFIX)/lib/bloonix/etc/conf.d; \
	fi;

	for file in \
		check-lm-sensors \
	; do \
		cp -a sudoers/$$file $(PREFIX)/lib/bloonix/etc/sudoers.d/$$file; \
		chmod 440 $(PREFIX)/lib/bloonix/etc/sudoers.d/$$file; \
		cp -a sudoers/$$file.conf $(PREFIX)/lib/bloonix/etc/conf.d/$$file.conf; \
		chmod 644 $(PREFIX)/lib/bloonix/etc/conf.d/$$file.conf; \
	done;

clean:

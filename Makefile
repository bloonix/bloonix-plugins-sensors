CONFIG=Makefile.config

include $(CONFIG)

default: build

build:

	cp sudoers/60_bloonix_check_lm_sensors.in sudoers/60_bloonix_check_lm_sensors; \
	sed -i "s!@@PREFIX@@!$(PREFIX)!g" sudoers/60_bloonix_check_lm_sensors;

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

	cp -a sudoers/60_bloonix_check_lm_sensors $(PREFIX)/lib/bloonix/etc/sudoers.d/60_bloonix_check_lm_sensors; \
	chmod 644 $(PREFIX)/lib/bloonix/etc/sudoers.d/60_bloonix_check_lm_sensors;

	if test ! -e "$(PREFIX)/lib/bloonix/etc/conf.d" ; then \
		mkdir -p $(PREFIX)/lib/bloonix/etc/conf.d; \
		chmod 755 $(PREFIX)/lib/bloonix/etc/conf.d; \
	fi;

	cp -a sudoers/check-lm-sensors.conf $(PREFIX)/lib/bloonix/etc/conf.d/check-lm-sensors.conf; \
	chmod 644 $(PREFIX)/lib/bloonix/etc/conf.d/check-lm-sensors.conf;

clean:

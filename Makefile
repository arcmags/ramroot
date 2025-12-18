.PHONY: null
null:
	@:

.PHONY: install
install:
	install -Dm644 usr/lib/initcpio/hooks/ramroot "$(PREFIX)/usr/lib/initcpio/hooks/ramroot"
	install -Dm644 usr/lib/initcpio/install/ramroot "$(PREFIX)/usr/lib/initcpio/install/ramroot"
	install -Dm644 usr/lib/ramroot/ramroot.conf "$(PREFIX)/usr/lib/ramroot/ramroot.conf"
	install -Dm644 usr/lib/ramroot/ramroot.conf "$(PREFIX)/etc/ramroot.conf"
	install -Dm644 usr/lib/ramroot/ramroot.z/etc/issue.d/ramroot.issue "$(PREFIX)/etc/ramroot.z/etc/issue/issue.d/ramroot.issue"
	install -Dm644 usr/share/man/man8/ramroot.8 "$(PREFIX)/usr/share/man/man8/ramroot.8"
	install -Dm644 usr/share/man/man5/ramroot.conf.5 "$(PREFIX)/usr/share/man/man5/ramroot.conf.5"
	install -Dm644 LICENSE "$(PREFIX)/usr/share/licenses/ramroot/LICENSE"

.PHONY: uninstall
uninstall:
	rm -f "$(PREFIX)/usr/lib/initcpio/hooks/ramroot"
	rm -f "$(PREFIX)/usr/lib/initcpio/install/ramroot"
	rm -rf "$(PREFIX)/usr/lib/ramroot/"
	rm -f "$(PREFIX)/etc/ramroot.conf"
	rm -rf "$(PREFIX)/etc/ramroot.z/"
	rm -f "$(PREFIX)/usr/share/man/man8/ramroot.8"
	rm -f "$(PREFIX)/usr/share/man/man5/ramroot.conf.5"
	rm -rf "$(PREFIX)/usr/share/licenses/ramroot"

.PHONY: null
null:
	@:

.PHONY: install
install:
	install -Dm644 initcpio/hooks/ramroot "$(PREFIX)/usr/lib/initcpio/hooks/ramroot"
	install -Dm644 initcpio/install/ramroot "$(PREFIX)/usr/lib/initcpio/install/ramroot"
	install -Dm644 ramroot.conf "$(PREFIX)/usr/lib/ramroot/ramroot.conf"
	install -Dm644 ramroot.conf "$(PREFIX)/etc/ramroot.conf"
	install -Dm644 ramroot.issue "$(PREFIX)/etc/ramroot.z/etc/issue.d/ramroot.issue"
	install -Dm644 man/ramroot.8 "$(PREFIX)/usr/share/man/man8/ramroot.8"
	install -Dm644 man/ramroot.conf.5 "$(PREFIX)/usr/share/man/man5/ramroot.conf.5"
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

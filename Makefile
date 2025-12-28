.PHONY: null
null:
	@:

.PHONY: install
install:
	install -Dm644 initcpio/hooks/ramroot "$(DESTDIR)/usr/lib/initcpio/hooks/ramroot"
	install -Dm644 initcpio/install/ramroot "$(DESTDIR)/usr/lib/initcpio/install/ramroot"
	install -Dm644 initcpio/mkinitcpio.ramroot.conf "$(DESTDIR)/usr/lib/ramroot/mkinitcpio.ramroot.conf"
	install -Dm644 LICENSE "$(DESTDIR)/usr/share/licenses/ramroot/LICENSE"
	install -Dm644 man/ramroot.8 "$(DESTDIR)/usr/share/man/man8/ramroot.8"
	install -Dm644 ramroot.conf "$(DESTDIR)/etc/ramroot.conf"
	install -Dm644 ramroot.conf "$(DESTDIR)/usr/lib/ramroot/ramroot.conf"
	install -Dm644 ramroot.issue "$(DESTDIR)/etc/ramroot.z/etc/issue.d/ramroot.issue"
	install -Dm644 ramroot.issue "$(DESTDIR)/usr/lib/ramroot/ramroot.issue"

.PHONY: uninstall
uninstall:
	rm -rf "$(DESTDIR)/etc/ramroot.z/"
	rm -rf "$(DESTDIR)/usr/lib/ramroot/"
	rm -rf "$(DESTDIR)/usr/share/licenses/ramroot"
	rm -f "$(DESTDIR)/etc/ramroot.conf"
	rm -f "$(DESTDIR)/usr/lib/initcpio/hooks/ramroot"
	rm -f "$(DESTDIR)/usr/lib/initcpio/install/ramroot"
	rm -f "$(DESTDIR)/usr/share/man/man8/ramroot.8"

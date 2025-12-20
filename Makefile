.PHONY: null
null:
	@:

.PHONY: install
install:
	install -Dm644 initcpio/hooks/ramroot "$(DESTDIR)/usr/lib/initcpio/hooks/ramroot"
	install -Dm644 initcpio/install/ramroot "$(DESTDIR)/usr/lib/initcpio/install/ramroot"
	install -Dm644 initcpio/mkinitcpio.ramroot.conf "$(DESTDIR)/usr/lib/ramroot/mkinitcpio.ramroot.conf"
	install -Dm644 ramroot.conf "$(DESTDIR)/usr/lib/ramroot/ramroot.conf"
	install -Dm644 ramroot.conf "$(DESTDIR)/etc/ramroot.conf"
	install -Ddm755 "$(DESTDIR)/etc/ramroot.conf.d"
	install -Dm644 ramroot.issue "$(DESTDIR)/etc/ramroot.z/etc/issue.d/ramroot.issue"
	install -Dm644 man/ramroot.8 "$(DESTDIR)/usr/share/man/man8/ramroot.8"
	install -Dm644 man/ramroot.conf.5 "$(DESTDIR)/usr/share/man/man5/ramroot.conf.5"
	install -Dm644 LICENSE "$(DESTDIR)/usr/share/licenses/ramroot/LICENSE"

.PHONY: uninstall
uninstall:
	rm -f "$(DESTDIR)/usr/lib/initcpio/hooks/ramroot"
	rm -f "$(DESTDIR)/usr/lib/initcpio/install/ramroot"
	rm -rf "$(DESTDIR)/usr/lib/ramroot/"
	rm -f "$(DESTDIR)/etc/ramroot.conf"
	rm -rf "$(DESTDIR)/etc/ramroot.conf.d/"
	rm -rf "$(DESTDIR)/etc/ramroot.z/"
	rm -f "$(DESTDIR)/usr/share/man/man8/ramroot.8"
	rm -f "$(DESTDIR)/usr/share/man/man5/ramroot.conf.5"
	rm -rf "$(DESTDIR)/usr/share/licenses/ramroot"

.PHONY: null
null:
	@:

.PHONY: install
install:
	@# conf:
	install -Dm644 ramroot.conf "$(DESTDIR)/etc/ramroot.conf"
	install -Dm644 ramroot.issue "$(DESTDIR)/etc/ramroot.z/etc/issue.d/ramroot.issue"
	@# initcpio:
	install -Dm644 initcpio/hooks/ramroot "$(DESTDIR)/usr/lib/initcpio/hooks/ramroot"
	install -Dm644 initcpio/install/ramroot "$(DESTDIR)/usr/lib/initcpio/install/ramroot"
	@# lib:
	install -Dm644 initcpio/mkinitcpio.ramroot.conf "$(DESTDIR)/usr/lib/ramroot/mkinitcpio.ramroot.conf"
	install -Dm644 ramroot.conf "$(DESTDIR)/usr/lib/ramroot/ramroot.conf"
	install -Dm644 ramroot.issue "$(DESTDIR)/usr/lib/ramroot/ramroot.issue"
	@# license:
	install -Dm644 LICENSE "$(DESTDIR)/usr/share/licenses/ramroot/LICENSE"
	@# man:
	install -Dm644 man/ramroot.8 "$(DESTDIR)/usr/share/man/man8/ramroot.8"

.PHONY: uninstall
uninstall:
	@# conf:
	rm -f "$(DESTDIR)/etc/ramroot.conf"
	rm -rf "$(DESTDIR)/etc/ramroot.z/"
	@# initcpio:
	rm -f "$(DESTDIR)/usr/lib/initcpio/hooks/ramroot"
	rm -f "$(DESTDIR)/usr/lib/initcpio/install/ramroot"
	@# lib:
	rm -rf "$(DESTDIR)/usr/lib/ramroot/"
	@# license:
	rm -f "$(DESTDIR)/usr/share/licenses/ramroot"
	@# man:
	rm -f "$(DESTDIR)/usr/share/man/man8/ramroot.8"

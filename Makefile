.PHONY: null
null:
	@:

.PHONY: install
install:
	# initcpio hook:
	install -Dm644 initcpio/hooks/ramroot "$(DESTDIR)/usr/lib/initcpio/hooks/ramroot"
	install -Dm644 initcpio/install/ramroot "$(DESTDIR)/usr/lib/initcpio/install/ramroot"
	# lib:
	install -Dm644 initcpio/mkinitcpio.ramroot.conf "$(DESTDIR)/usr/lib/ramroot/mkinitcpio.ramroot.conf"
	install -Dm644 ramroot.conf "$(DESTDIR)/usr/lib/ramroot/ramroot.conf"
	install -Dm644 ramroot.issue "$(DESTDIR)/usr/lib/ramroot/ramroot.issue"
	# man:
	install -Dm644 LICENSE "$(DESTDIR)/usr/share/licenses/ramroot/LICENSE"
	install -Dm644 man/ramroot.8 "$(DESTDIR)/usr/share/man/man8/ramroot.8"
	# conf:
	install -Dm644 ramroot.conf "$(DESTDIR)/etc/ramroot.conf"
	install -Dm644 ramroot.issue "$(DESTDIR)/etc/ramroot.z/etc/issue.d/ramroot.issue"

.PHONY: uninstall
uninstall:
	# initcpio hook:
	rm -f "$(DESTDIR)/usr/lib/initcpio/hooks/ramroot"
	rm -f "$(DESTDIR)/usr/lib/initcpio/install/ramroot"
	# lib:
	rm -rf "$(DESTDIR)/usr/lib/ramroot/"
	# man:
	rm -f "$(DESTDIR)/usr/share/licenses/ramroot"
	rm -f "$(DESTDIR)/usr/share/man/man8/ramroot.8"
	# conf:
	rm -f "$(DESTDIR)/etc/ramroot.conf"
	rm -rf "$(DESTDIR)/etc/ramroot.z/"

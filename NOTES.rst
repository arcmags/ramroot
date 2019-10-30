=================
ramroot dev-notes
=================

A place to organize ideas, list new features, keep track of what
doesn't work, lol.


busybox shell
=============

The Arch Linux initramfs uses a modified version of the busybox_
ash_ shell.  By modified, I mean it contains only of fraction of
the usual busybox builtins.  The core Arch repository contains
a mkinitcpio-busybox_ which ... ahhhhhh!! God, just spent over 4
hours trying to figure out why *read* ain't working in ash and I'm
still stuck.


Somehow, whenever the damn prompt timer runs out, zramctl fails and I
have absolutely no clue why.


visual countdown broken
no awk
no tr
no -gt , only -lt
shell subs fucked
no ((n++))
no -z


Upcoming Features
=================

* ~/.ramroot user directory for ramroot specific user files

* possibly an option to drop to the busybox shell during initramfs


.. _ash: https://linux.die.net/man/1/ash
.. _busybox: https://busybox.net/downloads/BusyBox.html
.. _mkinitcpio-busybox: https://www.archlinux.org/packages/core/x86_64/mkinitcpio-busybox/

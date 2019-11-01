=================
ramroot dev notes
=================

A place to organize ideas, list new features, keep track of what
doesn't work, lol.


busybox shell
=============

The Arch Linux initramfs uses a modified version of the busybox_
ash_ shell.  To test out this trimmed down shell, install
mkinitcpio-busybox_ and run::

    PATH= /usr/lib/initcpio/busybox ash


Upcoming Features
=================

* ~/.ramroot user directory for ramroot specific user files

* systemd unit to copy custom ramroot files post initramfs stage?

* possibly an option to drop to the busybox shell during initramfs


Questions
=========

* Where should the */etc/ramroot* folder really go?  Should it be named
  *ramroot.d*?  It doesn't really fit what a *.d* directory is for;
  heck, it doesn't really fit what any system directory is for.  Hmm...
  Maybe */etc/ramroot.r* then?  Or even better, */etc/ramroot.z*, I
  like it.

* When should */etc/ramroot* files be copied to the root filesystem?
  Right now it happens during initramfs, but I feel like this isn't
  the time you want to be doing something like that.  A systemd unit
  starting right after local-fs.target would probably work as well.
  The idea is to have any custom files copied before any service that sources them starts.  Need to look into this...


.. _ash: https://linux.die.net/man/1/ash
.. _busybox: https://busybox.net/downloads/BusyBox.html
.. _mkinitcpio-busybox: https://www.archlinux.org/packages/core/x86_64/mkinitcpio-busybox/

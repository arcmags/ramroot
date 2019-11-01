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

* Eventually going to have to get this working with dracut_...


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


Bugs
====

* Something is really weird with the visual countdown prompt. (Official
  release is okay, I'm talking about the current master branch.)  For
  some reason I have failed to determine after literally days of
  toil, initializing the zram device fails on some machines every time
  the boot timer is allowed to expire and succeeds every time a key is
  pressed before the timer expires.  It appears to have something to
  do with the timer expiring yet there is absolutely no logical
  reason this should matter.  WTF?  I may remove the visual countdown
  prompt as it seems to be the only solution at this point...


.. _ash: https://linux.die.net/man/1/ash
.. _busybox: https://busybox.net/downloads/BusyBox.html
.. _dracut: https://dracut.wiki.kernel.org/index.php/Main_Page
.. _mkinitcpio-busybox: https://www.archlinux.org/packages/core/x86_64/mkinitcpio-busybox/

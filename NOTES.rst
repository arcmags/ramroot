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

*   ~/.ramroot user directory for ramroot specific user files

*   Eventually going to have to get this working with dracut_...

*   Possibly use a systemed unit to copy files from */etc/ramroot.z*
    after local-fs.target instead of during initramfs.


.. _ash: https://linux.die.net/man/1/ash
.. _busybox: https://busybox.net/downloads/BusyBox.html
.. _dracut: https://dracut.wiki.kernel.org/index.php/Main_Page
.. _mkinitcpio-busybox: https://www.archlinux.org/packages/core/x86_64/mkinitcpio-busybox/

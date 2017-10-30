=======
ramroot
=======

Run Linux entirely from RAM!  This project creates and enables a custom
mkinitcpio_ hook that completely loads the root (and /boot) filesystem into
RAM during the initramfs_ boot stage.


Requirements
============

Arch Linux
    This is was designed specifically to work with the Arch Linux
    `boot process`_.  I suspect these scripts may work with slight
    modifications on other distributions as well, however this is
    currently untested.

sudo
    These scripts can all be run as root, or as a normal user with sudo
    privileges.  The scripts will call sudo when necessary to modify or
    create initcpio files.


Usage
=====

``ramroot [options]``
    All actions are invoked with the *ramroot* script.  At least one option
    of either *--enable*, *--disable*, or *--remove* must be specified.


Options
=======

``-b, --boot [UUID]``
    Specify the */boot* UUID to use when building hooks; necessary if
    unable to detect UUID via *lsblk* or */etc/fstab*.

``-D, --disable``
    Disable ramroot.  Remove ramroot HOOK and required MODULES from
    */etc/mkinitcpio.conf* and rebuild linux cpio boot image.

``-E, --enable``
    Enable ramroot.  Rebuild build and runtime hooks and place in
    */usr/lib/initcpio*.  Add ramroot HOOK and required MODULES to
    */etc/mkinitcpio.conf* and rebuild linux cpio boot image.

``-H, --help``
    Display help text and exit.

``-K, --keep``
    Keep copies of new build and runtime hooks in *~/.cache/ramroot*.

``-r, --root [UUID]``
    Specify the root UUID to use when building hooks; necessary if
    unable to detect UUID via lsblk or */etc/fstab*.

``-R, --remove``
    Disable ramroot and remove build and runtime hooks from
    */usr/lib/initcpio*.


Operation
=========

If ramroot is enabled, during the initial phase of the boot process,
the amount of available RAM on the computer along with the size of the
root filesystem to be copied is detected and shown on the screen.  If the
available RAM is at least 500MB larger that the root filesystem, a [y/n]
confirmation appears to load the root filesystem to RAM. (Confirmation
prompt defaults to *yes* with a 15 second timeout.)

The size of the zram partition created is determined by taking the size of
the root filesystem plus half of the extra available RAM to a maximum of 6GB.

The filesystem transfer to RAM can take several minutes.  As soon as the boot
process is complete, the USB device (or whatever boot device) can be removed.

Remember that all changes to files in RAM are completely lost once the
computer is shutdown.  To update the system and edit files, boot the device
without transferring the filesystem to RAM.


Tips
====

Keep a clean and trimmed down system to maintain faster RAM sync times.
Arch Linux stores downloaded packages in */var/cache/pacman/pkg/*.  After
every update, if no problems occur, consider removing `old packages`_.
Execute ``pacman -Sc`` to remove all packages that aren't currently installed.
Execute ``paccache -rk0`` to remove all packages.

From experience: higher quality (more expensive) USB flash drives
often exhibit a huge improvement in sync times.


Issues / to do (maybe)
======================

*   add a ramroot-flush function to sync the RAM filesystem back to the
    initial boot device (simple)

*   test on other distros

*   package up for the AUR_

*   add support for other partitions users may have

*   make a webpage to go along with arch-usb_.


Credits
=======

This project was motivated greatly in part by the liveroot_ package and
by several inquisitive `forum posts`_.

:License:
    GPL 3.0

:Author:
    Chris Magyar

:Donations:
    XMR: 41dUPANhvCvLUuRVJpUc9cRFnsLHzWiTPUhyuamrVwa61    xoPuxZaD6R28cLqxEhTaC6LuwcHtkbUi2uELDD88MoQHJKePvP


.. _mkinitcpio: https://wiki.archlinux.org/index.php/mkinitcpio
.. _zram: https://en.wikipedia.org/wiki/Zram
.. _initramfs: https://en.wikipedia.org/wiki/Initial_ramdisk
.. _boot process: https://wiki.archlinux.org/index.php/Arch_boot_process
.. _build hook: https://wiki.archlinux.org/index.php/mkinitcpio#Build_hooks
.. _runtime hook: https://wiki.archlinux.org/index.php/mkinitcpio#Runtime_hooks
.. _HOOKS: https://wiki.archlinux.org/index.php/mkinitcpio#HOOKS
.. _MODULES: https://wiki.archlinux.org/index.php/mkinitcpio#MODULES
.. _AUR: https://aur.archlinux.org/
.. _arch-usb: http://valleycat.org/arch-usb/arch-usb.html
.. _old packages: https://wiki.archlinux.org/index.php/pacman#Cleaning_the_package_cache
.. _liveroot: https://github.com/bluerider/liveroot
.. _forum posts: https://bbs.archlinux.org/viewtopic.php?id=178963

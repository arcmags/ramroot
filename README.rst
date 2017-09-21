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
    These scripts can all be run as root, however, running them as a non
    elevated user is recommended.  The scripts call sudo when necessary
    to modify or create initcpio files.


Installation
============

All installation scripts are located in the *bin/* directory.  In order to
obtain correct UUIDs, you must install from a normal login session (no chroot).
To build and enable ramroot in one step, simply run the ``ramroot-enable``
script.  The newly built scripts are placed in a new *build/* directory
within the respository as well as copied to their required source locations in
the filesystem.

``ramroot-build``
    This creates and copies the ramroot `build hook`_ and `runtime hook`_ to
    */usr/lib/initcpio/install/ramroot* and */usr/lib/initcpio/hooks/ramroot*
    respectively.

``ramroot-enable``
    This script adds ramroot to the HOOKS_ array directly after the udev hook
    in */etc/mkinitcpio.conf*.  Additionally, module requirements
    ext4 and zram are added to the MODULES_ array.  A new new linux kernel
    image is generated with these changes via `mkinitcpio -p linux`.

``ramroot-disable``
    This script removes the ramroot hook and ext4, zram module requirements
    in */etc/mkinitcpio.conf*.  A new kernel image is generated.

``ramroot-remove``
    This ensures ramroot is disabled in */etc/mkinitcpio.conf* and removes the
    initcpio hooks at */usr/lib/initcpio/install/ramroot* and
    */usr/lib/initcpio/hooks/ramroot*.


Usage
=====

Once fully enabled, all that is required is a reboot.  During the initial
phase of the boot process, the amount of detected RAM is displayed along with
a [y/n] prompt asking if the user wishes to load the root filesystem to RAM.
(Note that this prompt defaults to *yes* with a 10 second timeout if 4G or more
of RAM is detected.)

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

Consider that higher quality (more expensive) USB jump drives will
exhibit a noticeable difference in sync times.


Issues / to do (maybe)
======================

*   add a ramroot-flush function to sync the RAM filesystem back to the
    initial boot device (simple)

*   find a way to get UUIDs while in arch-chroot to allow installing via chroot

*   perhaps combine all the *bin/ramroot-** scripts into one, or at least

    *   source common functions from a single file?

*   test on other distros

*   package up for the AUR_

*   add support for other partitions users may have

*   could source fstab for information?

*   warnings/no installing if user's root filesystem is to large?

*   check filesystem size during boot

    *   default [y/n] answer at boot dependent on RAM and filesystem sizes

*   add command line options to ``ramroot-build``

    *   control [y/n] prompt behavior/existence

    *   specify UUIDs

*   make a webpage to go along with arch-usb_.


Credits
=======

:Author:
    Chris Magyar

:License:
    BSD 3-Clause

This project was motivated greatly in part by the liveroot_ package and
by several inquisitive `forum posts`_.


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

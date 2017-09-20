========
ram-root
========

Run Linux entirely from RAM!  This project creates and enables a custom
mkinitcpio hook that completely loads the root (and /boot) filesystem into
RAM during boot.

Once installed and enabled, the user will be prompted to load the root
filesystem to a zram_ partition during the initramfs_ stage of the
`boot process`_.


Installation
============

All installation scripts are located in the ``bin/`` directory.  In order to
obtain correct UUIDs, you must install from a normal login session (no chroot).
All install scripts must be run as root.  To use ramroot, first install the
hook, then enable the changes:

1.  ``ramroot-install`` builds the required hook and install files

2.  ``ramroot-enable`` adds the necessary mkinitcpio MODULES and HOOKS



.. _zram: https://en.wikipedia.org/wiki/Zram
.. _initramfs: https://en.wikipedia.org/wiki/Initial_ramdisk
.. _boot process: https://wiki.archlinux.org/index.php/Arch_boot_process

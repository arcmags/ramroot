=======
ramroot
=======

Run Linux entirely from RAM! This is a customizable mkinitcpio_ hook that
completely loads the root file system to a zram partition during the initramfs_
boot stage.


Usage
=====

During early system boot, the ramroot initcpio hook determines the host
machine's total ram and prompts the user y/n to load the root file system to
zram if enough space is available.

A ramroot helper script easily enables/disables and/or generates additional
ramroot config files.

Installation
------------

This package is available in the AUR_ for easy installation. A basic config
file is created during initial installation.

Requirements
------------

Arch Linux
    ramroot is designed specifically to work with the Arch Linux `boot
    process`_. These scripts work with slight modifications on other
    distributions from time to time, however this not officially supported

mkinitcpio
    Create custom initial ramdisk image.


Configuration
=============

/etc/ramroot.conf
-----------------

This file is an ash shell script. Many common bash builtins are not available
here and the syntax tends to be a bit stricter. The fallback config file can be
viewed at */usr/lib/ramroot/ramroot.conf*.

After any changes are made to */etc/ramroot.conf*, a user must execute
``ramroot -E`` or ``mkinitcpio -P`` in order for those changes to be built into
a new initramfs image.

All *UUID* (or *PARTUUID*) values must include the proper ``UUID=`` prefix. A
*mountpath* is an absolute mount path (as given in */etc/fstab*). Every size is
a whole number of *mebibytes* with *no-suffix*.

``mounts_zram``
    Additional mounts loaded to zram when ramroot is active. A mount consists
    of the *UUID* separated from the *mountpath* by a colon. Multiple mounts
    are separated by spaces or newlines.

``mounts_null``
    Mounts excluded when ramroot is active. The *UUID* is optional for these
    mounts. These will not be loaded to zram or mounted normally. If */* is
    specified in ``mounts_null``, ramroot will skip loading altogether.

``ps_default``
    Default zram boot y/n prompt value. Valid values are *yes* or *no*.

``ps_timeout``
    zram boot prompt timeout, positive integer between 1 and 32. After this
    many seconds, the prompt will select the ``ps_default`` value.

``ram_min``
    Minimum amount of free ram required.

``zram_min``
    Minimum amount of free zram required. If both this and ``ram_min`` cannot
    be satisfied, the zram boot prompt will automatically select *no*.

``ram_pref``
    Preferred amount of free ram. Additional memory is allocated to ram up to
    this preferred value.

``zram_max``
    Maximum amount of free zram. If ``ram_pref`` is satisfied, free zram is
    increased to ``zram_max``.

All remaining memory is allocated towards ram.

/etc/ramroot.z/
---------------

The structure of this directory mirrors the hierarchy of the root file system.
Upon a successful sync to zram, any files and directories contained in
*/etc/ramroot/* are non-persistently overwritten to the root directory.

This can be used to load any number of custom scripts, binaries, configs, etc
when boot from zram. A few use case examples for this include: a custom zram
hostname at */etc/ramroot.z/etc/hostname*, enable autologin when boot from zram
via a */etc/ramroot.z/etc/systemd/system/getty@tty1.service.d/override.conf*
file, or even add more sudo access with drop in files in
*/etc/ramroot.z/etc/sudoers.d/*.

Any files copied from */etc/ramroot.z/* to */* in this manner preserve all
ownerships. Be wary that any symbolic links (rather than their target files)
will be overwritten by this action as they aren't resolved yet during early
initramfs.

~/.ramroot.z/
-------------

Any files contained within a *~/.ramroot.z* directory in a user's home
folder are non-persistently overwritten to their home folders upon a
sync to zram as described in */etc/ramroot.z/* above.


Ramroot Script
==============

``ramroot <options>``

Options
-------

``-C, --config-gen``
    Attempt to detect the root file system partitions and generate a new config
    file.

``-D, --disable``
    Remove ramroot hook from */etc/mkinitcpio.conf* and rebuild initramfs
    image.

``-E, --enable``
    Add ramroot hook to */etc/mkinitcpio.conf* and rebuild initramfs image.

``-o, --output <FILE>``
    Save new config to *FILE* instead of */etc/mkinitcpio.conf*.

``-Y, --yes``
    Overwrite output files without asking.

``-H, --help``
    Display help text and exit.


Notes
=====

The file system transfer to zram takes several minutes. As soon as the boot
process is complete, the boot media can be safely removed.

Remember that all changes to files in zram are completely lost when the host
machine is power cycled. To persistently update the system and edit files, boot
the device without transferring the filesystem to zram.

Keep a clean and trimmed down system to maintain faster zram sync times. Arch
Linux stores downloaded packages in */var/cache/pacman/pkg/*. Consider removing
`old packages`_ after system updates.

Higher quality (more expensive) USB flash drives exhibit a dramatic improvement
in zram sync times.


Credits
=======

This project was motivated greatly in part by the liveroot_ package and by
several inquisitive `forum posts`_.

:Author:
    Chris Magyar

:Version:
    2.0.2

:License:
    GPL 3.0

:Donate(xmr):
    41dUPANhvCvLUuRVJpUc9cRFnsLHzWiTPUhyuamrVwa61xoP
    uxZaD6R28cLqxEhTaC6LuwcHtkbUi2uELDD88MoQHJKePvP


.. _AUR: https://aur.archlinux.org/packages/ramroot/
.. _mkinitcpio: https://wiki.archlinux.org/index.php/mkinitcpio
.. _zram: https://en.wikipedia.org/wiki/Zram
.. _initramfs: https://en.wikipedia.org/wiki/Initial_ramdisk
.. _boot process: https://wiki.archlinux.org/index.php/Arch_boot_process
.. _build hook: https://wiki.archlinux.org/index.php/mkinitcpio#Build_hooks
.. _runtime hook: https://wiki.archlinux.org/index.php/mkinitcpio#Runtime_hooks
.. _HOOKS: https://wiki.archlinux.org/index.php/mkinitcpio#HOOKS
.. _MODULES: https://wiki.archlinux.org/index.php/mkinitcpio#MODULES
.. _arch-usb: http://valleycat.org/arch-usb/arch-usb.html
.. _old packages: https://wiki.archlinux.org/index.php/pacman#Cleaning_the_package_cache
.. _liveroot: https://github.com/bluerider/liveroot
.. _forum posts: https://bbs.archlinux.org/viewtopic.php?id=178963

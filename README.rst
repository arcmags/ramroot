=======
ramroot
=======

Run Linux entirely from RAM! This is a customizable mkinitcpio_ hook that
completely loads the root file system to a zram device during the initramfs_
boot stage.


Usage
=====

During early system boot, the ramroot initcpio hook determines the host
machine's total ram and prompts the user y/n to load the root file system to
zram if enough space is available.

Installation and Setup
----------------------

Install the hooks and manpages::

    # make install

Uninstall::

    # make uninstall

After installation, the ``ramroot`` hook must be manually added to
*/etc/mkinitcpio.conf*. This was done via script in the past (before I realized
it's probably not a great idea to change users' */etc/mkinitcpio.conf* in an
install script).

As of mkinitcpio-v40_, Arch Linux has begun including the ``systemd`` hook in
*/etc/mkinitcpio.conf* by default. This version of ramroot is not (yet)
compatible with this hook. See the non-systemd hooks in the official
meson.build_ from mkinitcpio. Adding the ``ramroot`` hook after the ``udev``
hook enables ramroot::

    HOOKS=(base udev ramroot autodetect microcode modconf kms keyboard keymap consolefont block filesystems fsck)

Users are responsible for dealing with their own */etc/mkinitcpio.conf* files themselves

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

:Author:
    Chris Magyar

:Version:
    2.0.3

:License:
    GPL 3.0


.. _AUR: https://aur.archlinux.org/packages/ramroot/
.. _mkinitcpio: https://wiki.archlinux.org/index.php/mkinitcpio
.. _mkinitcpio-v40: https://github.com/archlinux/mkinitcpio/tree/v40
.. _zram: https://en.wikipedia.org/wiki/Zram
.. _meson.build: https://github.com/archlinux/mkinitcpio/blob/v40/meson.build
.. _initramfs: https://en.wikipedia.org/wiki/Initial_ramdisk
.. _boot process: https://wiki.archlinux.org/index.php/Arch_boot_process
.. _build hook: https://wiki.archlinux.org/index.php/mkinitcpio#Build_hooks
.. _runtime hook: https://wiki.archlinux.org/index.php/mkinitcpio#Runtime_hooks
.. _HOOKS: https://wiki.archlinux.org/index.php/mkinitcpio#HOOKS
.. _MODULES: https://wiki.archlinux.org/index.php/mkinitcpio#MODULES
.. _arch-usb: http://valleycat.org/arch-usb/arch-usb.html
.. _old packages: https://wiki.archlinux.org/index.php/pacman#Cleaning_the_package_cache

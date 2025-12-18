# ramroot

ramroot is a mkinitcpio hook that loads the root file system to a zram device
during the initramfs boot stage.

## Installation

Install hooks and manpages:

    # make install

Uninstall:

    # man uninstall

After installation, the `ramroot` hook must be manually added to
*/etc/mkinitcpio.conf*. This was done via script in the past (before I realized
it's probably not a great idea to change users' */etc/mkinitcpio.conf* in an
install script).

As of [mkinitcpio-v40][v40], Arch Linux has begun including the `systemd` hook
in */etc/mkinitcpio.conf* by default. This version of ramroot is not (yet)
compatible with this hook. See the non-systemd hooks in the official
[meson.build][meson.build] from mkinitcpio. Adding the `ramroot` hook after the
`udev` hook enables ramroot:

    HOOKS=(base udev ramroot autodetect microcode modconf kms keyboard keymap consolefont block filesystems fsck)

Rebuild initramfs images to include changes made to */etc/mkinitcpio.conf*:

    # mkinitcpio -P

Users are responsible for dealing with their own */etc/mkinitcpio.conf* and any
*.pacnew* files.

## Configuration

### /etc/ramroot.conf

ash shell script setting the following values:

`mounts_zram`
: Additional mounts loaded to zram when ramroot is active. A mount consists of
the *UUID* separated from the *mountpath* by a colon. Multiple mounts are
separated by spaces or newlines.

`mounts_null`
: Mounts excluded when ramroot is active. The *UUID* is optional for these
mounts. These will not be loaded to zram or mounted normally.

`ps_default`
: Default zram boot y/n prompt value. Valid values are *yes* or *no*.

`ps_timeout`
: zram boot prompt timeout, positive integer between 1 and 32. After this many
seconds, the prompt will select the `ps_default` value.

`ram_min`
: Minimum amount of free ram required.

`zram_min`
: Minimum amount of free zram required. If both this and `ram_min` cannot be
satisfied, the zram boot prompt will automatically select *no*.

`ram_pref`
: Preferred amount of free ram. Additional memory is allocated to ram up to
this preferred value.

`zram_max`
Maximum amount of free zram. If `ram_pref` is satisfied, free zram is
increased to `zram_max`.

All remaining memory is allocated towards ram.

### /etc/ramroot.z/

The structure of this directory mirrors the hierarchy of the root file system.
Upon a successful sync to zram, any files and directories contained in
*/etc/ramroot/* are non-persistently overwritten to the root directory.

This can be used to load any number of custom scripts, binaries, configs, etc
when boot from zram. A few use case examples for this include: a custom zram
hostname at */etc/ramroot.z/etc/hostname*, enable autologin when boot from zram
via a */etc/ramroot.z/etc/systemd/system/getty@tty1.service.d/override.conf*
file, etc.

Any files copied from */etc/ramroot.z/* to */* in this manner preserve all
ownerships. Be wary that any symbolic links (rather than their target files)
will be overwritten by this action as they aren't resolved yet during early
initramfs.

### ~/.ramroot.z/

Any files contained within a *~/.ramroot.z* directory in a user's home folder
are non-persistently overwritten to their home folders upon a sync to zram as
described for */etc/ramroot.z/* above.

## Requirements
- Arch Linux
- mkinitcpio

[GPLv3](https://www.gnu.org/licenses/gpl-3.0) | [mags](https://mags.zone)

[v40]: https://github.com/archlinux/mkinitcpio/tree/v40
[meson.build]: https://github.com/archlinux/mkinitcpio/blob/v40/meson.build

<!--metadata:
author: Chris Magyar <c.magyar.ec@gmail.com>
description:
keywords: Arch Linux, zram, ramroot
-->

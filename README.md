# ramroot

ramroot is a [mkinitcpio][mkinitcpio] hook that loads the root file system to a zram
device during the initramfs boot stage.

## Installation

Install hooks and manpages:

    # make install

Uninstall:

    # man uninstall

After installation, the `ramroot` hook must be manually added to
*/etc/mkinitcpio.conf* (or a file in */etc/mkinitcpio.conf.d/*). This was done
via script in the past (before I realized it's not a good idea to change users'
*/etc/mkinitcpio.conf* in an install script).

Ramroot is not (yet) compatible with a systemd based initramfs. See the
non-systemd hooks in the official [meson.build][meson.build] from mkinitcpio.
Using these hooks with `ramroot` added after `udev` enables ramroot:

    HOOKS=(base udev ramroot autodetect microcode modconf kms keyboard keymap consolefont block filesystems fsck)

The drop-in file *mkinitcpio.ramroot.conf* is provided that can be placed in
*/etc/mkinitcpio.conf.d/* to easily make these changes.

Rebuild initramfs to include changes:

    # mkinitcpio -P

Users are responsible for dealing with their own */etc/mkinitcpio.conf* and any
*.pacnew* files resulting from system updates.

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
when boot from zram.

Any files copied from */etc/ramroot.z/* to */* in this manner preserve all
ownerships. Be wary that symbolic links (rather than their target files) will
be overwritten by this action as they aren't resolved yet during early
initramfs.

### ~/.ramroot.z/

Any files contained within a *~/.ramroot.z* directory in a user's home folder
are non-persistently overwritten to their home folders upon a sync to zram as
described for */etc/ramroot.z/* above.

## Requirements
- Arch Linux
- mkinitcpio

[GPLv3](https://www.gnu.org/licenses/gpl-3.0) | [mags](https://mags.zone)

[meson.build]: https://github.com/archlinux/mkinitcpio/blob/v40/meson.build
[mkinitcpio]: https://wiki.archlinux.org/title/Mkinitcpio

<!--metadata:
author: Chris Magyar <c.magyar.ec@gmail.com>
description:
keywords: Arch Linux, zram, ramroot
-->

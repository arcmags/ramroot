# ramroot TODO

Things to add, subtract, think about...

- try busybox cp again, see if original issue with that is fixed
- verbose/quiet options
- systemd init compatibility
- more error checks
- some way to delete files when boot from ram
- more verbose messages about zram device creation/size/etc
- print message about adding to HOOKS when installing
- improve docs
- yaml config file
    - no risk of sourcing a malicious/bad shell file in init
    - added risk of parsing yaml in init
- unset unneeded vars in busybox hook
- /etc/ramroot.conf.d/ configs
- used defaults if no config file found
- memory/storage percentages in config file
- memory/storage KB, MB, GB, KiB, MiB, GiB suffixes in config file
- logging
- remove/reduce sleep commands in hook
- debug/shell option

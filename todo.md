# ramroot TODO

Things to add, subtract, think about...

- try busybox cp again, see if original issue with that is fixed
- rsync instead of cp (show progress)
- verbose/quiet options
- systemd init compatibility
- more error
- some way to delete files when boot from ram
- more verbose messages about zram device creation/size/etc
- print message about adding to HOOKS when installing
- improve docs
- yaml config file
    - no risk of sourcing a malicious/bad shell file in init
    - added risk of parsing yaml in init
- unset unneeded vars in busybox hook
- /etc/ramroot.conf.d/ config location
- used defaults if no config file found

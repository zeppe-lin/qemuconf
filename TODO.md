TODO qemuconf
=============


Next Release
------------
- [ ] GNU-style options/usage:
      https://github.com/zeppe-lin/qemuconf/issues/1

  qemuconf.c, qemuconf.1:
  - [x] use `getopt_long(3)` and the following long opts equivalents:
        -q/--qemubin, -n/--dryrun (--no-execute), -v/--version, -h/--help
  - [ ] document new options in the man page

  qemuconf-import, qemuconf-import.1
  - [ ] use GNU `getopt(1)` for opts parsing
  - [ ] add -v/--version and -h/--help opts

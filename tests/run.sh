#!/bin/sh
cd "$(dirname "$(which "$0")")" || exit 1

assert() {
	r="$(cat)"
	[ "$2" = "$r" ] && return 0

	echo "ERROR:     $1"
	echo "EXPECTED:  $2"
	echo "ACTUAL:    $r"
	echo "----"
	unset -v r
}

QEMUCONF="../qemuconf -n"

$QEMUCONF generic.conf | \
	assert "Parse example document" "/usr/bin/qemu-system-x86_64 -smp 2 -m 1024 -enable-kvm -drive if=virtio,file=hda.img -net nic,vlan=0,model=virtio,macaddr=82:82:9D:AF:F0:1C -net user,vlan=0 -vnc 127.0.0.1:1"

$QEMUCONF -q q 00.conf | \
	assert "Multiline argument" "q -foo bar,baz"

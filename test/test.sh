#! /bin/sh

cd $(dirname $(which $0))

assert() {
	local r="$(cat)"
	[ "$2" = "$r" ] && return 0;

	echo "ERROR:     $1"
	echo "EXPECTED:  $2"
	echo "ACTUAL:    $r"
	echo "----"
}

QEMUCONF="../qemuconf -n -q q"

$QEMUCONF ../example.conf | \
	assert "Parse example document" "/usr/bin/qemu-system-x86_64 -smp 8 -m 1024 -enable-kvm -cdrom ../void/void-live-x86_64-latest.iso -drive if=virtio,file=/dev/vg0/vm1 -net nic,vlan=0,model=virtio,macaddr=82:82:9D:AF:F0:1C -net user,vlan=0 -vnc 127.0.0.1:1"

$QEMUCONF 00.conf | \
	assert "Multiline argument" "q -foo bar,baz"

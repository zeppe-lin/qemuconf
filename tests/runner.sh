#!/bin/sh
# Test runner for qemuconf.

cd "$(dirname "$(which "$0")")" || exit 1

QEMUCONF="../qemuconf -n"
DIR="./data"

# Loop over all .conf files.
for conf in "$DIR"/*.conf; do
	case "$conf" in
	*.conf)          ;;
	     *) continue ;;
	esac

	base=$(basename "$conf" .conf)
	expect="$DIR/$base.expect"
	args="$DIR/$base.args"

	# Check for expected output.
	if [ ! -f "$expect" ]; then
		echo "x $base: missing .expect file"
		exit 1
	fi

	# Read args if present.
	if [ -f "$args" ]; then
		# Read args safely into positional parameters.
		set -- $(cat "$args")
	else
		set --
	fi

	# Run test.
	got="$($QEMUCONF "$@" "$conf")"
	want=$(cat "$expect")

	if [ "$got" = "$want" ]; then
		echo "[OK  ] $base"
	else
		echo "[FAIL] $base"
		echo "EXPECTED: $want"
		echo "ACTUAL:   $got"
		echo "----"
		exit 1
	fi
done

# vim: cc=72 tw=70
# End of file.

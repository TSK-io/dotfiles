#!/bin/sh

pcmanfm "$@" &

i=0
while [ "$i" -lt 40 ]; do
	if icesh -q -c pcmanfm -W this -L !Desktop -l sizeto 50% 100% top right raise >/dev/null 2>&1; then
		exit 0
	fi

	i=$((i + 1))
	sleep 0.05
done

exit 0

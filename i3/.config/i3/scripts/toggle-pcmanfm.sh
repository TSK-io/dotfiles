#!/bin/sh

if i3-msg -t get_tree | jq -e '.. | objects | select(.window_properties.class == "Pcmanfm")' >/dev/null; then
	i3-msg '[class="^Pcmanfm$"] kill' >/dev/null
else
	pcmanfm -n "$HOME" >/dev/null 2>&1 &
fi

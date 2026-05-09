#!/bin/bash
FILE=$(mktemp -u --suffix=.png)
scrot -s "$FILE" || exit 0
feh --title i3-pinshot --borderless "$FILE" &

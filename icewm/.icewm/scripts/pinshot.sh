#!/bin/bash
FILE=$(mktemp -u --suffix=.png)
scrot -s "$FILE" || exit 0
feh --title icewm-pinshot --borderless "$FILE" &

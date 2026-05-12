#!/bin/sh

dir="/tmp/screenshots"
n=1

mkdir -p "$dir"

while [ -e "$dir/$n.png" ]; do
	n=$((n + 1))
done

file="$dir/$n.png"

scrot -fs "$file"
xclip -selection clipboard -t image/png -i "$file"

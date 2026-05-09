#!/bin/sh
scrot -fs - | xclip -selection clipboard -t image/png

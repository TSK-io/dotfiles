#!/bin/bash

# update && upgrade
pkg update && pkg upgrade -y
pkg install -y proot-distro
proot-distro install debian

#!/bin/bash

# update && upgrade
pkg update && pkg upgrade -y
pkg -y install proot-distro
proot-distro install debian

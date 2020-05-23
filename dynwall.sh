#!/usr/bin/env bash
# SPDX-License-Identifier: MIT
# Copyright (c) 2020 Chua Hou

# gnome session program
# something guaranteed to be running in gnome session for us to be able to get
# DBUS_SESSION_BUS_ADDRES below
GSESSION_PROGRAM=compton

# export DBUS_SESSION_BUS_ADDRESS as environment variable for cron
# https://stackoverflow.com/questions/10374520/gsettings-with-cron
PID=$(pgrep compton)
export DBUS_SESSION_BUS_ADDRESS=$(grep -z DBUS_SESSION_BUS_ADDRESS /proc/$PID/environ|cut -d= -f2-)

# gets current date and gets appropriate filename
IMAGES_DIR="$(realpath $(dirname $0))/images/"
IMAGES_EXT=".png"
FILENAME=$(date +"%H" | xargs printf "file://$IMAGES_DIR%s$IMAGES_EXT")

# set wallpaper
gsettings set org.gnome.desktop.background picture-uri "$FILENAME"

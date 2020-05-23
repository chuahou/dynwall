# dynwall

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)

Simple dynamic wallpaper script for setting GNOME desktop wallpaper based on
time of day. The appropriate image in images/ named `(HOUR).png` is chosen at
every time the script is called.

The script only sets the wallpaper and depends on cron to run regularly.

## Attribution

Default collection of wallpapers in images/ are taken from _The 25th Hour_ by
[Louis Coyle](http://louie.co.nz/). The animation was played in full screen in
Google Chrome with photos taken at 1 to 2s intervals (highly irregular and
manual).

Images are NOT part of the MIT Licence. Only the scripts are.

Inspired by [dynamic-wallpaper](https://github.com/adi1090x/dynamic-wallpaper),
but I wanted something that worked as a cron job instead of constantly running.

## Usage

### cron

Firstly, identify some program that is guaranteed to be running in a GNOME
session. This might be `gnome-session` itself, or a compositor like `picom` or
`compton`. Then, replace `GSESSION_PROGRAM=compton` in dynwall.sh with your
program, like so: `GSESSION_PROGRAM=<your program>`.

This is required because when run by cron, we need to use some trickery
to get the `DBUS_SESSION_BUSADDRESS` in order to use gsettings to set the
wallpaper.

Add the following line to your crontab:

```
1 * * * * /path/to/dynwall/dynwall.sh
```

We set the job to run at minute 1, so that there is no chance of any mistake
with cron triggering the job just before the hour and `date +"%H"` returning the
previous hour.

To trigger manually, run dynwall.sh directly. The cron job will ensure it
updates every hour.

### watch (untested)

If using watch or some other program to call the script regularly, there is no
need to set `GSESSION_PROGRAM`. Simply add something like

```
watch -n 300 /path/to/dynwall/dynwall.sh
```

to some init file (not tested).

## Custom wallpapers

Simply fill the images folder with your choice of wallpapers from 0.png to
23.png, corresponding to the hour you want them to appear. Symlinks are allowed;
in fact the default ones are symlinks to a collection of screenshots in
images/all.

## Dependencies

- GNOME based desktop environment
- Git LFS

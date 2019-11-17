#!/bin/sh

userresources=$HOME/.Xresources
usermodmap=$HOME/.Xmodmap
sysresources=/etc/X11/xinit/.Xresources
sysmodmap=/etc/X11/xinit/.Xmodmap

# merge in defaults and keymaps

if [ -f $sysresources ]; then
    xrdb -merge $sysresources

fi

if [ -f $sysmodmap ]; then
    xmodmap $sysmodmap
fi

if [ -f "$userresources" ]; then
    xrdb -merge "$userresources"

fi

if [ -f "$usermodmap" ]; then
    xmodmap "$usermodmap"
fi

# start some nice programs

if [ -d /etc/X11/xinit/xinitrc.d ] ; then
 for f in /etc/X11/xinit/xinitrc.d/?*.sh ; do
  [ -x "$f" ] && . "$f"
 done
 unset f
fi

# Started in i3 config
# Look for random background image
# if [ -f /usr/bin/feh ]; then
# 	feh --bg-max --randomize ~/.wallpaper/* &
# fi

# Started in i3 config
# Start compositor
# if [ -f /usr/bin/picom]; then
#	picom --fading --daemon --config "$HOME/.config/i3/picom.conf"
#fi

if [ -f /usr/bin/xbindkeys ]; then
    xbindkeys
fi

# Backlight setting
if [ -f /usr/bin/redshift ]; then
	redshift -c "$HOME/.config/redshift/redshift.conf" &
fi

# run i3 forever -- log to a tmp file and move if we need 'em
if [ -f /usr/bin/i3 ]; then
	exec i3 -V >> /tmp/i3.log 2>&1
fi

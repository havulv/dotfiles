#
# ~/.bash_profile
#

[[ -f ~/.bashrc ]] && . ~/.bashrc

# MPD daemon if it doesn't exist
[ ! -s ~/.config/mpd/pid ] && mpd


if [[ ! $DISPLAY && $XDG_VTNR -eq 1 ]]; then
	exec startx
fi

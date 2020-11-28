#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

if [[ "$(uname -s)" == "Linux" ]]; then
    alias ls='ls --color=auto'
    PS1='[\u@\h \W]\$ '
fi

# export MPD_HOST="/run/mpd/socket"

# Add a local binary placement
# Add a script directory to the PATH
export PATH="${PATH}:${HOME}/.local/bin/:${HOME}/.scripts/:/usr/bin/python"

# Add go binaries to path
export PATH="${PATH}:${HOME}/.go/bin/"

# Add scripts to the bash env
# shellcheck disable=SC1090
source "$(which virtualenvwrapper.sh)"

# Add special go paths -- I know it is not idiomatic,
# but I don't operate that way google. `\_(-_-)_/`
export GOPATH=$HOME/.go/

# Less does not like symlinks, so the the history file needs to
# be pointed at directly
export LESSHISTFILE="${HOME}/.dotfiles/less/.lesshst"

# Export secrets to the env -- ignoring spaces and comments
# BSD based distros don't support -d for xargs 
if [[ "$(uname -s)" == "Darwin" ||
    "$(uname -s)" == "BSD" ]]; then
    # shellcheck disable=SC2046
    export $(grep -v '^#' ~/.env | xargs -0)
else
    # shellcheck disable=SC2046
    export $(grep -v '^#' ~/.env | xargs -d '\n')
fi

# Run wal if it is installed
if hash wal 2> /dev/null ; then
    if [[ ! -f "/tmp/wal.lock" ]]; then
        # We create a "lock" file in /tmp/ so that we don't reload the background 
        # we open a new terminal -- turns out this is pretty expensive to do :|
        # We only need to run wal on first terminal start anyways
        # TODO: lock on a directory so that it is an atomic lock (right now there is a race condition)
        touch /tmp/wal.lock

        if [[ "$(uname -s)" == "Darwin" ]]; then
            wallpaper_path=$(osascript -e 'tell app "finder" to get posix path of (get desktop picture as alias)' | sed s+.dotfiles/wallpaper/++)
            if [[ "$wallpaper_path" != "$(jq '.wallpaper' "$HOME/.cache/wal/colors.json" | tr -d '"')" ]]; then
                wal -R
            else
                wal -R -n
            fi
        else
            wal -R
        fi
    else
        # Skip setting the background and reloading the wm
        # This should only load the color scheme for the terminal
        wal -Rneq
    fi
fi

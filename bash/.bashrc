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
source $(which virtualenvwrapper.sh)

# Add special go paths -- I know it is not idiomatic,
# but I don't operate that way google. `\_(-_-)_/`
export GOPATH=$HOME/.go/
alias dep=$HOME/.go/bin/dep

# Less does not like symlinks, so the the history file needs to
# be pointed at directly
export LESSHISTFILE="${HOME}/.dotfiles/less/.lesshst"

# Export secrets to the env -- ignoring spaces and comments
# BSD based distros don't support -d for xargs 
if [[ "$(uname -s)" == "Darwin" ||
     "$(uname -s)" == "BSD" ]]; then
     export $(grep -v '^#' ~/.env | xargs -0)
else
    export $(grep -v '^#' ~/.env | xargs -d '\n')
fi

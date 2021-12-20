
# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# replaces directory names with the results of word expansion.
shopt -s direxpand

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
#shopt -s globstar

# Improve default ll alias
alias ll='ls -lah --color=auto'

case "$TERM" in
    xterm-color|*-256color) color_prompt=yes;;
esac
eval `dircolors /entry/dircolors`
export PS1="\[\e[35m\][\[\e[m\]\[\e[35m\]SL7Docker\[\e[m\]\[\e[35m\]]\[\e[m\]\[\e[34m\]\w\[\e[m\]: "
source /cvmfs/dune.opensciencegrid.org/products/dune/setup_dune.sh

# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

#enable globstar
shopt -s globstar

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
#HISTSIZE=1000
#HISTFILESIZE=2000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
#shopt -s globstar

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color|*-256color) color_prompt=yes;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
	# We have color support; assume it's compliant with Ecma-48
	# (ISO/IEC-6429). (Lack of such support is extremely rare, and such
	# a case would tend to support setf rather than setaf.)
        color_prompt=yes
    else
        color_prompt=
    fi
    echo "$color_prompt" > /dev/null 2>&1 # to remove synstasic warning
fi

#if [ "$color_prompt" = yes ]; then
    #PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
#else
    #PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
#fi
unset color_prompt force_color_prompt

################################################################### PS0 PS1 PS2

DIRECTORY="\w"
DOUBLE_SPACE="  "
NEWLINE="\n"
NO_COLOUR="\e[00m"
PRINTING_OFF="\["
PRINTING_ON="\]"
PROMPT_COLOUR="\e[0;33m"
PS1_PROMPT="\$"
PS2_PROMPT=">"
RESTORE_CURSOR_POSITION="\e[u"
SAVE_CURSOR_POSITION="\e[s"
SINGLE_SPACE=" "
TIMESTAMP="\A"
TIMESTAMP_PLACEHOLDER="--:--"

move_cursor_to_start_of_ps1() {
    command_rows=$(history 1 | wc -l)
    if [ "$command_rows" -gt 1 ]; then
        let vertical_movement=$command_rows+1
    else
        command=$(history 1 | sed 's/^\s*[0-9]*\s*//')
        command_length=${#command}
        ps1_prompt_length=${#PS1_PROMPT}
        let total_length=$command_length+$ps1_prompt_length
        let lines=$total_length/${COLUMNS}+1
        let vertical_movement=$lines+1
    fi
    tput cuu $vertical_movement
}

PS0_ELEMENTS=(
    "$SAVE_CURSOR_POSITION" "\$(move_cursor_to_start_of_ps1)"
    "$PROMPT_COLOUR" "$TIMESTAMP" "$NO_COLOUR" "$RESTORE_CURSOR_POSITION"
)
PS0=$(IFS=; echo "${PS0_ELEMENTS[*]}")
echo "$PS0" > /dev/null 2>&1 # ro remove synstastic warning

PS1_ELEMENTS=(
    # Empty line after last command.
    "$NEWLINE"
    # First line of prompt.
    "$PRINTING_OFF" "$PROMPT_COLOUR" "$PRINTING_ON"
    "$TIMESTAMP_PLACEHOLDER" "$DOUBLE_SPACE" "$DIRECTORY" "$PRINTING_OFF"
    "$NO_COLOUR" "$PRINTING_ON" "$NEWLINE"
    # Second line of prompt.
    "$PRINTING_OFF" "$PROMPT_COLOUR" "$PRINTING_ON" "$PS1_PROMPT"
    "$SINGLE_SPACE" "$PRINTING_OFF" "$NO_COLOUR" "$PRINTING_ON"
)
PS1=$(IFS=; echo "${PS1_ELEMENTS[*]}")

PS2_ELEMENTS=(
    "$PRINTING_OFF" "$PROMPT_COLOUR" "$PRINTING_ON" "$PS2_PROMPT"
    "$SINGLE_SPACE" "$PRINTING_OFF" "$NO_COLOUR" "$PRINTING_ON"
)
PS2=$(IFS=; echo "${PS2_ELEMENTS[*]}")

shopt -s histverify

################################################################### PS0 PS1 PS2

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
*)
    ;;
esac

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi

# added by cuda
export PATH="$PATH:/usr/local/cuda-9.0/bin"

# added by cuda
export LD_LIBRARY_PATH="$LD_LIBRARY_PATH:/usr/local/cuda-9.0/lib64"
export LD_LIBRARY_PATH="$LD_LIBRARY_PATH:/usr/local/cuda/extras/CUPTI/lib64"

####################
# Aliases          #
####################

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

####################
# Functions        #
####################

if [ -f ~/.bash_functions ]; then
    . ~/.bash_functions
fi

source /etc/profile.d/undistract-me.sh

####################
#                  #
####################

export VISUAL=nvim
export EDITOR="$VISUAL"

# HSTR configuration - add this to ~/.bashrc
# https://github.com/dvorka/hstr
alias hh=hstr                    # hh to be alias for hstr
export HSTR_CONFIG=hicolor       # get more colors
# already in a previous line
#shopt -s histappend              # append new history items to .bash_history
#export HISTCONTROL=ignorespace   # leading space hides commands from history
export HISTFILESIZE=10000        # increase history file size (default is 500)
export HISTSIZE=${HISTFILESIZE}  # increase history size (default is 500)
# ensure synchronization between bash memory and history file
export PROMPT_COMMAND="history -a; history -n; ${PROMPT_COMMAND}"
# if this is interactive shell, then bind hstr to Ctrl-r (for Vi mode check doc)
if [[ $- =~ .*i.* ]]; then bind '"\C-r": "\C-a hstr -- \C-j"'; fi
# if this is interactive shell, then bind 'kill last command' to Ctrl-x k
if [[ $- =~ .*i.* ]]; then bind '"\C-xk": "\C-a hstr -k \C-j"'; fi


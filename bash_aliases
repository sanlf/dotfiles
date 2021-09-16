####################
# Aliases          #
####################

alias vim="nvim"
alias sudo="sudo "

#for youtube-dl downloaded from https://yt-dl.org/latest/youtube-dl ##########
alias youtube-dl='/usr/local/bin/youtube-dl'

#mpv aliases #################################################################
# no subs
alias mpv-ns='mpv --no-sub-visibility'
# load file with <anime4k-1080p perceptual quality and deblur> shader
alias mpv4k='mpv --profile="anime4k-1080-perceptual-quality-deblur"'
# load playlist
alias mplaylist='mpv --idle=once --script-opts=playlistmanager-loadfiles_on_start=yes --save-position-on-quit'
# load playlist
alias mplaylist4k='mpv4k --idle=once --script-opts=playlistmanager-loadfiles_on_start=yes --save-position-on-quit'
# no video and no audio cover
alias mpv3='mpv --no-audio-display --no-video'

#color support################################################################
# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto -v'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# colored GCC warnings and errors
#export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

# some more ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'


#tmux aliases ################################################################
# tmux alias new work session
alias tmuxw='tmuxn work'

#other aliases ###############################################################
# move file to trash
alias mvt='gio trash'

#qol aliases #################################################################
alias mkdir="mkdir -p "
alias cp="cp -iv "
alias mv="mv -iv "
sensors="watch sensors"


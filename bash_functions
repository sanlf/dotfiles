#!/bin/bash

####################
# Functions        #
####################

# create directories and cd to the first one
mkcd()
{
    mkdir -p "$@"
    cd "$1" || return
}

# compares the sha256 of two files and prints whether they are equal or not
cmpsha256()
{
    file1=$( sha256sum "$1" )
    file2=$( sha256sum "$2" )
    if [[ "$file1" == "$file2" ]]; then
        echo "EQUAL";
    else
        echo "DIFFERENT";
    fi
}

#Prints the resolution of a video file. The output's format is
# width x height e.g. 1080x1920
vidres()
{
    if [ "$#" -gt 0 ]
    then
        while [ "$#" -gt 0 ]
        do
            echo "$1" | vidres
            shift
        done
        return "$?"
    fi
    while read -r file; do
        ffprobe -v error -select_streams v:0 -show_entries stream=width,height -of csv=s=x:p=0 "$file"
    done
}

#opens man in vim read mode
viman()
{
    man "$1" | vim -RM -
}

####################
# tmux functions   #
####################


tmuxn()
{
    tmux attach -t "$1" \; display "Attached to existing session" || \
        tmux new -s "$1" \; display "New session created"
}

misc-tmux()
{
    tmux send-keys "cd ~" C-m
    #echo "misc-tmux"
}

music-tmux()
{
    tmux send-keys "cd ~/Music" C-m
}

videos-tmux()
{
    tmux send-keys "cd ~/Videos" C-m
}

# searches for tmux session with names, if none then creates a new ones
tmuxs()
{
    sessions=( misc music videos )

    for session in "${sessions[@]}"
    do
        tmux has-session -t "$session" 2>/dev/null
        if [[ "$?" -eq 1 ]]
        then
            tmux new -d -s "$session"
            $session-tmux
        fi
    done

    tmux attach -t "${sessions[0]}"
}

# converts seconds to hours:minutes:seconds
convsecs()
{
    param=${1:-/dev/stdin}
    while read -r secs; do
        stripsecs=$( printf "%.0f" "$secs" )
        printf '%dh:%dm:%ds\n' $((stripsecs/3600)) \
                               $((stripsecs%3600/60)) \
                               $((stripsecs%60))
    done < "$param"
}

# gets the combined duration of music files
audioduration()
{
    soxi -D "$@" | awk 'BEGIN { s = 0 }; { s = s + $1 }; END { print s }'  | convsecs
    #ffprobe -i "$@" -show_entries format=duration -v quiet -of csv="p=0" | awk 'BEGIN { s = 0 }; { s = s + $1 }; END { print s }'  | convsecs
}

# plays all the files in the current directory in random order
playdir()
{
    mpv --no-audio-display --no-video --playlist=<( find "$PWD" -maxdepth 1 -type f | shuf )
}

# picks 15 random images from the ~/Pictures/General/ directory and displays them in a list
randimg()
{
    images_location="$HOME/Pictures/General/"
    find "$images_location" -maxdepth 1 -type f | shuf | head -n 15 | \
        sed -e 's/^/"/g' -e 's/$/"/g' | xargs eog
}

# comines apt update and apt upgrade in a single command.
updategrade()
{
    sudo apt update && sudo apt upgrade
}

untar()
{
    tar -xvf "$1"
}

untargz()
{
    tar -xvzf "$1"
}

youtube_to_xml()
{
    IFS="/"
    read -ra url <<< $1
    local channel_id="${url[-1]}"
    local id_type="${url[-2]}"

    echo "Channel ID: $channel_id"

    if [ $id_type != "channel" ] && [ $id_type != "user" ]
    then
        echo "ID type is neither channel nor user!"
        echo "In order to get the channel ID, follow the next steps:"
        echo "Ctrl+U"
        echo "View resource"
        echo "Search externalID"
        echo "The string following is the channel id"
        echo "Concatenate to the end of the following string:"
        echo "https://www.youtube.com/feeds/videos.xml?channel_id="

        return 1
    fi

    if [ $id_type = "channel" ]
    then
        id_type="channel_id"
    fi


    local xml="https://www.youtube.com/feeds/videos.xml?$id_type=$channel_id"

    echo "$xml"
}

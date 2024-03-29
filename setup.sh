#!/bin/bash

############################
# setup.sh
#
# This file may need sudo permissions to run.
#
# Creates symlinks from the home directory to any desired dotfiles in ~/dotfiles
# Installs neovim and python-is-python3
#
############################

########## Variables

dir=~/dotfiles                    # dotfiles directory
olddir=~/dotfiles_old             # old dotfiles backup directory
files="bashrc vimrc mpv tmux.conf"    # list of files/folders to symlink in homedir
package_manager="apt"

##########

# create dotfiles_old in homedir
echo "Creating $olddir for backup of any existing dotfiles in ~"
mkdir -p $olddir
echo "...done"

# change to the dotfiles directory
echo "Changing to the $dir directory"
cd $dir
echo "...done"

# move any existing dotfiles in homedir to dotfiles_old directory, then create symlinks
for file in $files; do
    echo "Moving any existing dotfiles from ~ to $olddir"
    mv ~/.$file ~/dotfiles_old/
    echo "Creating symlink to $file in home directory."
    ln -s $dir/$file ~/.$file
done

exists_nvim=$(which nvim)
# installing packages (needs sudo)
if [ -z "${exists_nvim}" ]; then
	"${package_manager}" install neovim
fi
"${package_manager}" install python-is-python3

# verify neovim is installed
if hash nvim 2>/dev/null; then
    echo "neovim is installed. Continuing normally."

    #symlinks vim directory and vimrc for neovim
    ln -s ~/.vim ~/.config/nvim
    ln -s ~/.vimrc ~/.config/nvim/init.vim

    #install vim-plug for neovim
    curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
else
    echo "neovim is not installed. Aborting.";
    exit 1;
fi

# To install it right away for all UNIX users (Linux, OS X, etc.), type:
curl -L https://yt-dl.org/downloads/latest/youtube-dl -o /usr/local/bin/youtube-dl
chmod a+rx /usr/local/bin/youtube-dl

#########

# install go if doesn't exist
exists_go=$(which go)
if [ -z "${exists_go}" ]; then
    "${package_manager}" install golang
fi

# install hydroxide
git clone https://github.com/emersion/hydroxide.git
cd hydroxide
GO111MODULE=on go build ./cmd/hydroxide
sudo mv hydroxide /usr/local/bin
cd ..
rm -rf hydroxide/

echo "[Unit]
Description=Protonmail bridge for sanlf@protonmail.com
After=network.target
StartLimitIntervalSec=0[Service]

[Service]
Type=simple
Restart=always
RestartSec=1
User=sanlf
ExecStart=/usr/local/bin/hydroxide -smtp-port 1025 -imap-port 1143 -carddav-port 8015 serve

[Install]
WantedBy=multi-user.target" >> /etc/systemd/system/sanlf-hydroxide.service

echo "Remember to run hydroxide auth <username> and follow what the link says: https://github.com/emersion/hydroxide"

# install undistract-me
sudo ${package_manager} install undistract-me


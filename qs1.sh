#!/bin/bash

source ~/quickstart/local/initvars.sh

sudo apt-get -yq install git-core
sudo apt-get -yq install git 
# add some useful git tools
sudo apt-get -yq install gitg meld git-gui gitk
sudo apt-get -yq install wget curl

## configure some nice git settings
git config --global color.ui true
git config --global core.whitespace trailing-space,tab-in-indent

## Install java - 100mb
sudo apt-get -yq install default-jre


## Basic editors

# Config gedit-2
gconftool-2 -s /apps/gedit-2/preferences/editor/auto_indent/auto_indent --type=bool true
gconftool-2 -s /apps/gedit-2/preferences/editor/bracket_matching/bracket_matching --type=bool true
gconftool-2 -s /apps/gedit-2/preferences/editor/line_numbers/display_line_numbers --type=bool true
gconftool-2 -s /apps/gedit-2/preferences/editor/current_line/highlight_current_line --type=bool true
gconftool-2 -s /apps/gedit-2/preferences/editor/right_margin/display_right_margin --type=bool true
gconftool-2 -s /apps/gedit-2/preferences/editor/wrap_mode/wrap_mode --type=string GTK_WRAP_NONE
gconftool-2 -s /apps/gedit-2/preferences/editor/tabs/insert_spaces --type=bool true
gconftool-2 -s /apps/gedit-2/preferences/editor/tabs/tabs_size --type=integer 2
gconftool-2 -s /apps/gedit-2/preferences/editor/save/auto_save --type=bool true
sudo apt-get -yq install gedit-plugins

# gnome terminal
gconftool-2 -s /apps/gnome-terminal/profiles/Default/scrollback_unlimited --type=bool true


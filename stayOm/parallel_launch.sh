#!/bin/bash

trap "killall chuckj" EXIT

#BASH_POST_RC='cd aux2;chuckj song_top.ck --silent --srate:44100; ' gnome-terminal

BASH_POST_RC='cd aux1; ctopj_solo;' gnome-terminal
BASH_POST_RC='cd aux3; ctopj_solo;' gnome-terminal

chuckj song_top.ck --bufsize4096 --srate:44100;

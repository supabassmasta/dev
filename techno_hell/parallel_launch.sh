#!/bin/bash

trap "killall chuckj" EXIT

BASH_POST_RC='cd aux1; ctopj;' gnome-terminal
BASH_POST_RC='cd aux2; ctopj;' gnome-terminal
BASH_POST_RC='cd aux3; ctopj;' gnome-terminal

chuckj song_top.ck --bufsize4096 --srate:44100;

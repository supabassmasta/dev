#!/bin/bash

trap "killall chuckp" EXIT

#BASH_POST_RC='cd aux2;chuckj song_top.ck --silent --srate:44100; ' gnome-terminal

BASH_POST_RC='cd aux1; ctopp_solo;' gnome-terminal
BASH_POST_RC='cd aux3; ctopp_solo;' gnome-terminal

chuckp song_top.ck  --srate:44100;

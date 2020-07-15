#!/bin/bash

trap "killall chuckj" EXIT

BASH_POST_RC='cd aux1; ctopj_solo;' gnome-terminal

#      !!!!!! !     UNCOMMENT FOR SILENT AUX2    !!!!!!!!!!!!!!!!!
# BASH_POST_RC='cd aux2;chuckj song_top.ck --silent --srate:44100; ' gnome-terminal


#not wolrking above for aux2:
#cpulimit -e chuckj -l 25 -b;
BASH_POST_RC='cd aux3; ctopj_solo;' gnome-terminal

chuckj song_top.ck --bufsize4096 --srate:44100;

#!/bin/bash

BASH_POST_RC='cd aux1; ddd --args chuckj song_top.ck --srate:44100;' gnome-terminal
BASH_POST_RC='cd aux2; ddd --args chuckj song_top.ck --srate:44100;' gnome-terminal
BASH_POST_RC='cd aux3; ddd --args chuckj song_top.ck --srate:44100;' gnome-terminal

ddd --args chuckj song_top.ck --srate:44100

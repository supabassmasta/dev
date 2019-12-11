#!/bin/bash

BASH_POST_RC='cd ../parallel_test_aux1; ctopj;' gnome-terminal
BASH_POST_RC='cd ../parallel_test_aux2; ctopj;' gnome-terminal
BASH_POST_RC='cd ../parallel_test_aux3; ctopj;' gnome-terminal


chuckj song_top.ck --bufsize4096 --srate:44100

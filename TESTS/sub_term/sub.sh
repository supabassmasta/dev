#!/bin/sh

trap "killall chuckj" EXIT

BASH_POST_RC='echo coucou;'  gnome-terminal

echo caca

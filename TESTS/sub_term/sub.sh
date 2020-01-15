#!/bin/sh

trap "killall background" EXIT

BASH_POST_RC='echo coucou;'  gnome-terminal

echo caca

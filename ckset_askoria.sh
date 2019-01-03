#!/bin/bash

#chuckcfg;
sudo chmod +r /dev/input/event4;

#lsdev;
ls -l /dev/input/by-path/;ls -l /dev/input;

echo ""
echo "PRESS ENTER TO CONTINUE"
echo ""
read tmp;

qjackctl &

echo ""
echo "PRESS ENTER TO CONTINUE"
echo ""
read tmp;

# to execute commands in child terminal:
# add following line at the end of .bashrc: eval "$BASH_POST_RC"
# call term this way: BASH_POST_RC='echo coucou;echo cucu;' gnome-terminal


gnome-terminal --working-directory=$PWD/intro_tempura/ --geometry 118x82+0+0
gnome-terminal --working-directory=$PWD/ayawaska/ --geometry 118x82+0+0
gnome-terminal --working-directory=$PWD/costa_dub/ --geometry 118x82-0+0
gnome-terminal --working-directory=$PWD/mantra/ --geometry 118x82+0+0
gnome-terminal --working-directory=$PWD/deep_glass/ --geometry 118x82-0+0
gnome-terminal --working-directory=$PWD/bollywood_DnB/ --geometry 118x82+0+0
gnome-terminal --working-directory=$PWD/kudumbao/ --geometry 118x82-0+0

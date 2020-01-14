#!/bin/bash

sudo rm /usr/bin/chuckp
sudo rm /usr/bin/chuckj

sudo ln -s /usr/bin/chuckp1400 /usr/bin/chuckp
sudo ln -s /usr/bin/chuckj1400 /usr/bin/chuckj


sudo rm /usr/local/lib/chuck
sudo ln -s /usr/local/lib/chuck_1400 /usr/local/lib/chuck


#!/bin/bash

sudo rm /usr/bin/chuckp
sudo rm /usr/bin/chuckj
sudo ln -s /usr/bin/chuckp1352 /usr/bin/chuckp
sudo ln -s /usr/bin/chuckj1352 /usr/bin/chuckj


sudo rm /usr/local/lib/chuck
sudo ln -s /usr/local/lib/chuck_1352 /usr/local/lib/chuck


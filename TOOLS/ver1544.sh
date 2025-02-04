#!/bin/bash

sudo rm /usr/bin/chuckp
sudo rm /usr/bin/chuckj
sudo ln -s /usr/bin/chuckp1544 /usr/bin/chuckp
sudo ln -s /usr/bin/chuckj1544 /usr/bin/chuckj


sudo rm /usr/local/lib/chuck
sudo ln -s /usr/local/lib/chuck_1544 /usr/local/lib/chuck


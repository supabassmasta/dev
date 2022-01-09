#!/bin/bash

# Handle Ctr C interrupt
trap ctrl_c INT
function ctrl_c() {
  echo ""
  echo "PROGRAM INTERUPTED"
  # STOP 
  killall lsp-plugins-impulse-reverb-stereo
  rm output_numbers.txt
  exit 0
}

./conv_rev_connect.sh &
echo 4 > output_numbers.txt
chuckj song_top.ck --out4




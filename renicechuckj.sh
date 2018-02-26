#!/bin/bash

PID=$(pidof chuckj)
echo $PID
if [[  $PID ]]; then
  sudo renice -20 -p $PID
  echo "Renice SUCCESS"
else 
  echo "Renice FAILED"
fi

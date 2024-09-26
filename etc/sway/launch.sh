#!/bin/bash

swaymsg "layout tabbed"
sleep 0.3s
swaymsg "exec /usr/bin/foot /usr/bin/tmux new \; splitw -v \; neww \; splitw -v \; splitw -h \; selectw -t 0\;"
sleep 0.3s

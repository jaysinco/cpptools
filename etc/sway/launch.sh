#!/bin/bash

swaymsg "layout tabbed"
sleep 0.3s
swaymsg "exec /usr/bin/foot /usr/bin/tmux new \; splitw -v \; selectp -t 0 \; splitw -h \; selectp -t 2 \; splitw -h \; splitw -v \; selectp -t 0"
sleep 0.3s

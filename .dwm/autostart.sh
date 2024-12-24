#!/bin/bash
setxkbmap -option "caps:escape_shifted_capslock" &
/usr/lib/mate-polkit/polkit-mate-authentication-agent-1 &
xfce4-power-manager &
feh --bg-fill ~/Pictures/wall.jpg &
picom &
flameshot &
xinput set-prop "Synaptics TM3127-001" "libinput Tapping Enabled" 1 &
/home/ansh/.dwm/status.sh &
/usr/lib/xfce4/notifyd/xfce4-notifyd &

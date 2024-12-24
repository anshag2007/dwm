#!/bin/bash

# Function to get volume and mute status
get_volume() {
    pactl list sinks | awk '
    /^\s*Mute: /{mute=$2} 
    /^\s*Volume: /{volume=$5; if (mute == "yes") print "Muted"; else print volume}' | head -n 1
}

# Function to get current time
get_time() {
    date "+%H:%M"
}

# Function to get battery status using upower
get_battery() {
    battery_info=$(upower -i $(upower -e | grep 'BAT') | grep -E "percentage" | awk '{print $2}')

    if [[ -z $battery_info ]]; then
        echo "No Battery"
    else
        echo "$battery_info"
    fi
}

# Function to get WiFi ESSID
get_wifi() {
    essid=$(nmcli -t -f active,ssid dev wifi | awk -F: '$1 == "yes" {print $2}')
    if [[ -z $essid ]]; then
        echo "Disconnected"
    else
        echo "$essid"
    fi
}

# Main loop to update the status bar
while true; do
    # Fetch each component
    volume=$(get_volume)
    time=$(get_time)
    battery=$(get_battery)
    wifi=$(get_wifi)
    
    # Combine them into one status string
    status="♪: $volume  ⚡: $battery  W: $wifi  $time"
    
    # Update the root window name
    xprop -root -set WM_NAME "$status"
    
    # Sleep to prevent excessive updates
    sleep 1
done


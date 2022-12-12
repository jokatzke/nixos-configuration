#!/usr/bin/env bash
# gnome authentication agent
/usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1 &
# clipboard
wl-clipboard &
# blue-light filter

# enable numlock by default
numlockx on &
# connect to vpn on startup
mullvad connect &
# kde-connect for connection with android phones
# kdeconnect-indicator &

# mullvad-vpn &
# thunderbird &
# slack &
# anki &
# telegram-desktop &
# mattermost-desktop &
# signal-desktop &
# emacs --daemon &
# emacsclient -a '' -c -e "(org-agenda-list)" &

### UNCOMMENT ONLY ONE OF THE FOLLOWING THREE OPTIONS! ###
# 1. Uncomment to restore last saved wallpaper
# xargs xwallpaper --stretch < ~/.xwallpaper &
# 2. Uncomment to set a random wallpaper on login
# find /usr/share/backgrounds/dtos-backgrounds/ -type f | shuf -n 1 | xargs xwallpaper --stretch &
# 3. Uncomment to set wallpaper with nitrogen
# nitrogen --restore &
# feh --bg-fill ~/Pictures/Wallpaper/ultrawide.jpg --bg-fill ~/Pictures/Wallpaper/normal.png

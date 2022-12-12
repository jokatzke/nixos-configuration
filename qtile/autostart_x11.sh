#!/usr/bin/env bash
fish ~/.config/qtile/scripts/autorandr_cycle.fish
# lxsession &
# compositor
# picom &
# gnome authentication agent
# /usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1 &
# pulse audio applet
# pa-applet &
# nm-applet &
# tray-icon for pamac; looks for updates
# pamac-tray &
# clipboard
clipit &
# blue-light filter
# redshift-gtk &
# for corsair keyboards / mice
# ckb-next -b &
# mate-power-manager &
# set keyboard layout to programmer dvorak with caps -> backspace
# bash $HOME/.config/scripts/set_dvorak.sh &
# enable numlock by default
# numlockx on &
# connect to vpn on startup
# mullvad connect &
# kde-connect for connection with android phones
# kdeconnect-indicator &
# set keyboard layout
# setxkbmap us altgr-intl &

# bash $HOME/.config/scripts/languagetool_server.sh &
# languagetool-http-server &

# mullvad-vpn &
# thunderbird &
# slack &
# anki &
# telegram-desktop &
# mattermost-desktop &
element-desktop &
# emacs --daemon &
# emacsclient -a '' -c -e "(org-agenda-list)" &

### UNCOMMENT ONLY ONE OF THE FOLLOWING THREE OPTIONS! ###
# 1. Uncomment to restore last saved wallpaper
# xargs xwallpaper --stretch < ~/.xwallpaper &
# 2. Uncomment to set a random wallpaper on login
# find /usr/share/backgrounds/dtos-backgrounds/ -type f | shuf -n 1 | xargs xwallpaper --stretch &
# 3. Uncomment to set wallpaper with nitrogen
# nitrogen --restore &
feh --bg-fill ~/Pictures/Wallpaper/ultrawide.jpg --bg-fill ~/Pictures/Wallpaper/normal.png

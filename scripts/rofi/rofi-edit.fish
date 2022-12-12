#!/usr/bin/env fish

set myEditor emacsclient -a '' -c
set myTerm urxvt
set myEdit nano

function menu
    for option in alacritty polybar i3 emacs qtile picom fish lf rofi Xresources gtd-inbox gtd-tickler gtd-someday gtd; printf $option\n; end
end

function main
    # list options in rofi and read choice
    set choice (menu | sort | rofi -matching fuzzy -i -dmenu)

    switch $choice
        case alacritty
            set file $HOME/.config/alacritty/alacritty.yml
        case i3
            set file $HOME/.config/i3/config
        case emacs
            set file $HOME/.config/doom/config.org
        case picom
            set file $HOME/.config/picom/picom.conf
        case fish
            set file $HOME/.config/fish/config.fish
        case lf
            set file $HOME/.config/lf/lfrc
        case polybar
            set file $HOME/.config/polybar/config
        case rofi
            set file $HOME/.config/rofi/config.rasi
        case Xresources
            set file $HOME/.Xresources
        case qtile
            set file $HOME/.config/qtile/README.org
        case gtd
            set file $HOME/gtd/gtd.org
        case gtd-inbox
            set file $HOME/gtd/inbox.org
        case gtd-tickler
            set file $HOME/gtd/tickler.org
        case gtd-someday
            set file $HOME/gtd/someday.org
        case "*"
            return
    end

    $myEditor $file & disown
end

main

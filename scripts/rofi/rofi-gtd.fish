#!/usr/bin/env fish

set gtd_inbox "$HOME/gtd/inbox.org"

function menu
    for option in 'Todo [inbox]' 'Information [inbox]'
        printf $option\n
    end
end

function main
    # Read the note type
    set choice (menu |  rofi -matching fuzzy -i -dmenu -p "Type of Note > ")
    if test -z $choice
        return
    end

    # Read the note content
    set item (echo | rofi -dmenu -location 0 -p "Note > " | sed 's/\//\\\\\//g' | sed 's/\&/\\\\\&/g')
    echo $item
    if test -z $item
        return
    end

    switch $choice
        case "Todo [inbox]"
            sed -i (string join "" 's/\* Tasks/\* Tasks\n** TODO ' $item "/") $gtd_inbox
        case "Information [inbox]"
            sed -i (string join "" 's/\* Information/\* Information\n** ' $item "/") $gtd_inbox
        case "*"
            return
    end
end

main

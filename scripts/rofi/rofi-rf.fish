#!/usr/bin/env fish

function main
    set choice (fasd -asR | sort -V -r | rofi -i -dmenu)
    set choice (echo $choice | sed "s/[0-9\.]*\s*//")

    if test -f $choice
        xdg-open $choice
    else if test -d $choice
        xdg-open $choice
    end

end

main

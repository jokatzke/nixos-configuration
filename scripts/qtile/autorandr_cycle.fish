#!/usr/bin/env fish

function main
    alias autorandr 'autorandr --skip-options x-prop-non_desktop'
    autorandr --cycle
    set profile (autorandr --current)
    switch $profile
        case two_default
            feh --bg-fill ~/Pictures/Wallpaper/ultrawide.jpg --bg-fill ~/Pictures/Wallpaper/normal.png
        case two_rotated_ultrawide
            feh --bg-fill ~/Pictures/Wallpaper/ultrawide_rotated.jpg --bg-fill ~/Pictures/Wallpaper/normal.png
        case "*"
            return
    end
end

main

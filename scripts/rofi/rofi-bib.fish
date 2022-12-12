#!/usr/bin/env fish

set file "$HOME/Books/Academics/library.bib"

function main
    # Read the data
    set title (echo | rofi -dmenu -location 0 -p "Title > ")
    if test -z $title
        return
    end
    set url (echo | rofi -dmenu -location 0 -p "Url > ")
    if test -z $url
        return
    end
    set author (echo | rofi -dmenu -location 0 -p "Author > ")
    if test -z $author
        return
    end

    # Construct id from url
    echo $url
    set id (echo $url | sed -e "s/.*\/\([^\/]*\)\$/\1/")
    set site (echo $url | sed -e "s/https*:\/\/\([^\/]*\).*/\1/")

    echo -e "\n@misc{$site:$id,\n  title = {$title},\n  url = {$url},\n  author = {$author},\n}" >>$file
end

main

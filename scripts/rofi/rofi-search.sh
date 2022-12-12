#!/usr/bin/env bash

# -----------------------------------------------------------------------------
# Info:
#   author:    Miroslav Vidovic
#   file:      web-search.sh
#   created:   24.02.2017.-08:59:54
#   revision:  ---
#   version:   1.0
# -----------------------------------------------------------------------------
# Requirements:
#   rofi
# Description:
#   Use rofi to search the web.
# Usage:
#   web-search.sh
# -----------------------------------------------------------------------------
# Script:

declare -A URLS

URLS=(
    ["Google"]="https://www.google.com/search?q=%s"
    ["Duck Duck Go"]="https://www.duckduckgo.com/?q=%s"
    ["GitHub"]="https://github.com/search?q=%s"
    ["Stack Overflow"]="http://stackoverflow.com/search?q=%s"
    ["IMDb"]="http://www.imdb.com/find?ref_=nv_sr_fn&q=%s"
    ["YouTube"]="https://www.youtube.com/results?search_query=%s"
    ["Arch Wiki"]="https://wiki.archlinux.org/index.php?search=%s&title=Special%3ASearch&profile=default&fulltext=1"
    ["Wikipedia"]="https://www.wikipedia.org/w/index.php?title=Special:Search&search=%s"
    ["Google Maps"]="https://www.google.com/maps?q=%s"
    ["Linguee: English-German"]="https://www.linguee.de/deutsch-englisch/search?source=auto&query=%s"
    ["Google Scholar"]="https://scholar.google.com/scholar?hl=en&q=%s"
    ["Wolfram Alpha"]="https://www.wolframalpha.com/input/?i=%s"
    ["Steam"]="https://store.steampowered.com/search/?term=%s"
    ["R"]="https://www.rdocumentation.org/search?q=%s"
    ["Board Game Geek"]="https://boardgamegeek.com/geeksearch.php?action=search&objecttype=boardgame&q=%s"
    ["PC Gaming Wiki"]="https://www.pcgamingwiki.com/w/index.php?search=%s&title=Special%3ASearch&profile=default&fulltext=1"
    ["ProtonDB"]="https://www.protondb.com/search?q=%s"
    ["fish-shell"]="https://fishshell.com/docs/current/search.html?q=%s"
    ["Ecosia"]="https://www.ecosia.org/search?q=%s"
)

# List for rofi
gen_list() {
    for i in "${!URLS[@]}"
    do
        echo "$i"
    done
}

main() {
    # Pass the list to rofi
    platform=$( (gen_list) | sort | rofi -dmenu -i -matching fuzzy -no-custom -location 0 -p "Search > " )

    if [[ -n "$platform" ]]; then
        query=$( (echo ) | rofi  -dmenu -matching fuzzy -location 0 -p "Query > " )

        if [[ -n "$query" ]]; then
            url=$( (echo ${URLS[$platform]}) | sed "s/%s/$query/g")
            printf $url
            # url=${URLS[$platform]}$query
            xdg-open "$url"
        else
            exit
        fi

    else
        exit
    fi
}

main

exit 0

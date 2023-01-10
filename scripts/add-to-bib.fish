#!/usr/bin/env fish

set file "$HOME/Books/Academics/library.bib"
set gtd_inbox "$HOME/gtd/inbox.org"

function main
    # Read the data
    read -P "Author > " author
    if test -z $author
        return
    end

    read -P "Title > " title
    if test -z $title
        return
    end

    read -P "url > " url
    if test -z $url
        return
    end

    # # Construct id from url
    # remove trailing forward-slash, if it exists
    set url (echo $url | sed -e "s/\/\$//")
    # set the id to the bottom-level domain, replacing colons with dots
    set id (echo $url | sed -e "s/.*\/\([^\/]*\)\$/\1/" | sed -e "s/:/./g")
    # set the site to the top-level domain, replacing colons with dots
    set site (echo $url | sed -e "s/https*:\/\/\([^\/]*\).*/\1/" | sed -e "s/:/./g")

    # append entry to the bibliography file
    echo -e "\n@misc{$site-$id,\n  title = {$title},\n  url = {$url},\n  author = {$author},\n}" >>$file
    # add TODO entry into gtd inbox
    sed -i "s/\* Tasks/\* Tasks\n** TODO process [cite:@$site-$id]: $title/" $gtd_inbox
end

main

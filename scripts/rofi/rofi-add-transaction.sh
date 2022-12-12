#!/usr/bin/env bash

main () {
    # ledger path
    ledgerPath="${HOME}/ledger/transactions"

    # users
    declare -A users
    users=(
        ["Jonas"]="jonas"
        ["Anna-Lena"]="anna-lena"
    )

    # get selected user
    gen_list() {
        for i in "${!users[@]}"
        do
            echo "$i"
        done
    }
    user=$( (gen_list) | sort | rofi -dmenu -i -matching fuzzy -no-custom -location 0 -p "User > " )
    if [ "$user" == "" ]; then
        exit 1
    fi

    # get date
    selectedDate=$( (printf "Today") | rofi  -dmenu -matching fuzzy -location 0 -p "Date > " )
    if [ "$selectedDate" == "Today" ]; then
        selectedDate=$(date +"%Y/%m/%d")
    fi
    if [ "$selectedDate" == "" ]; then
        exit 1
    fi

    # categories
    declare -A categories
    categories=(
        ["Contributions"]="Contributions"
        ["Gifts"]="Gifts"
        ["Groceries"]="Groceries"
        ["Food"]="Groceries:Food"
        ["Cleaning"]="Groceries:Cleaning"
        ["Hygiene"]="Groceries:Hygiene"
        ["Board Gaming"]="Hobby:Board Gaming"
        ["Cooking"]="Hobby:Cooking"
        ["Gaming"]="Hobby:Gaming"
        ["Reading"]="Hobby:Reading"
        ["Watching Movies / TV"]="Hobby:Watching Movie / TV"
        ["Stitching"]="Hobby:Stitching"
        ["Sports"]="Hobby:Sports"
        ["Eating Out"]="Hobby:Eating Out"
        ["Stationary"]="Hobby:Stationary"
        ["Insurance"]="Insurance"
        ["Insurance: Berufsunfähigkeitsversicherung"]="Insurance:BU"
        ["Insurance: Rentenversicherung"]="Insurance:Rentenversicherung"
        ["Health & Well-Being"]="Health & Well-Being"
        ["Prescription Meds"]="Health & Well-Being:Prescription Meds"
        ["Supplements"]="Health & Well-Being:Supplements"
        ["Glasses"]="Health & Well-Being:Glasses"
        ["Healthcare"]="Health & Well-Being:Healthcare"
        ["Dentist"]="Health & Well-Being:Healthcare:Dentist"
        ["Job"]="Job"
        ["Job: Transportation"]="Job:Transportation"
        ["Living"]="Living"
        ["Rent"]="Living:Rent"
        ["Internet"]="Living:Internet"
        ["Phone Bills"]="Living:Phone Bills"
        ["Water Bills"]="Living:Water Bills"
        ["Living: Miscellaneous"]="Living:Miscellaneous"
        ["Gas"]="Living:Gas"
        ["Shopping"]="Shopping"
        ["Tea"]="Shopping:Tea"
        ["Clothing"]="Shopping:Clothing"
        ["Furniture"]="Shopping:Furniture"
        ["Electronics"]="Shopping:Electronics"
        ["Beauty"]="Shopping:Beauty"
        ["General Transportation"]="Transportation"
        ["Vacation"]="Vacation"
        ["Vacation: Lodging"]="Vacation:Lodging"
        ["Vacation: Eating"]="Vacation:Eating"
        ["Vacation: Transportation"]="Vacation:Transportation"
    )

    # get selected category
    gen_list() {
        for i in "${!categories[@]}"
        do
            echo "$i"
        done
    }
    category=$( (gen_list) | sort | rofi -dmenu -i -matching fuzzy -no-custom -location 0 -p "Category > " )
    if [ "$category" == "" ]; then
        exit 1
    fi

    # get amount spent
    amount=$( (echo ) | rofi  -dmenu -matching fuzzy -location 0 -p "Amount Spent > " )
    if [ "$amount" == "" ]; then
        exit 1
    fi

    # get account used
    declare -A accounts
    accounts=(
        ["ING: Savings"]="Assets:$user:Savings:Savings Account:ING"
        ["ING: Bank Account"]="Assets:$user:Liquidity:Bank Account:ING"
        ["Wallet"]="Assets:$user:Liquidity:Wallet"
        ["On Credit"]="Liabilities:$user"
    )
    gen_list() {
        for i in "${!accounts[@]}"
        do
            echo "$i"
        done
    }
    account=$( (gen_list) | sort | rofi -dmenu -i -matching fuzzy -no-custom -location 0 -p "Account Used > " )
    if [ "$account" == "" ]; then
        exit 1
    fi

    # get comment
    comment=$( (echo ) | rofi  -dmenu -matching fuzzy -location 0 -p "Comment > " )

    # get tags
    tag=$(echo -e "Shared\nRecurrent\nOn-Credit\nNone" | sort | rofi -dmenu -i -multi-select | xargs -I{} echo {})
    if [ "$tag" == "None" ]; then
        tag=""
    fi

    # construct transaction and append to file
    # year=$(printf $selectedDate | sed "s/\(\d*\)\/.*/\1/")
    prefix=Expenses:$user
    if [ "$tag" != "" ]; then
        tag="   ; :$tag: \n"
    else
        tag=""
    fi
    printf "\n$selectedDate $comment\n   ; Generated from Rofi-script\n   ; Payee: $user\n$tag   $prefix:${categories[$category]}  $amount EUR\n   ${accounts[$account]}\n" >> "$ledgerPath/transactions.ledger"
}

main

exit 0

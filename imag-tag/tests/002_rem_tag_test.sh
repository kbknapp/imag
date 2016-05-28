#!/usr/bin/env bash

source $(dirname ${BASH_SOURCE[0]})/../../tests/utils.sh
source $(dirname ${BASH_SOURCE[0]})/utils.sh

test_rem_tag() {
    local id="test~0.2.0"
    mk_store_entry_with_tags $id
    imag-tag --id $id --add foo
    [[ ! $(entry_has_tag $id foo) ]] && err "Error adding tag" && return 1

    imag-tag --id $id --remove foo
    [[ ! $(entry_has_tag $id foo) ]]
}

test_rem_one_tag() {
    local id="test~0.2.0"
    mk_store_entry_with_tags $id
    imag-tag --id $id --add foo bar

    [[ $(entry_has_tag $id foo && entry_has_tag $id bar) ]] || \
        { err "Error adding tags"; return 1; }

    imag-tag --id $id --remove foo
    [[ $(entry_has_tag $id foo) ]] && err "Error removing one tag" && return 1

    imag-tag --id $id --remove bar
    [[ $(entry_has_tag $id bar) ]] && err "Error removing snd tag" && return 1
    return 0
}

test_rem_two_tags() {
    local id="test~0.2.0"
    mk_store_entry_with_tags $id
    imag-tag --id $id --add foo bar

    [[ $(entry_has_tag $id foo && entry_has_tag $id bar) ]] || \
        { err "Error adding tags"; return 1; }

    imag-tag --id $id --remove foo bar
    [[ $(entry_has_tag $id foo) ]] && err "Error removing one tag" && return 1
    [[ $(entry_has_tag $id bar) ]] && err "Error removing snd tag" && return 1
    return 0
}

test_rem_two_tags_comma() {
    local id="test~0.2.0"
    mk_store_entry_with_tags $id
    imag-tag --id $id --add foo bar

    [[ $(entry_has_tag $id foo && entry_has_tag $id bar) ]] || \
        { err "Error adding tags"; return 1; }

    imag-tag --id $id --remove foo,bar
    [[ $(entry_has_tag $id foo) ]] && err "Error removing one tag" && return 1
    [[ $(entry_has_tag $id bar) ]] && err "Error removing snd tag" && return 1
    return 0
}

test_rem_two_tags_comma_short() {
    local id="test~0.2.0"
    mk_store_entry_with_tags $id
    imag-tag --id $id --add foo bar

    [[ $(entry_has_tag $id foo && entry_has_tag $id bar) ]] || \
        { err "Error adding tags"; return 1; }

    imag-tag --id $id -r foo,bar
    [[ $(entry_has_tag $id foo) ]] && err "Error removing one tag" && return 1
    [[ $(entry_has_tag $id bar) ]] && err "Error removing snd tag" && return 1
    return 0
}

invoke_tests                            \
    test_rem_tag                        \
    test_rem_two_tags                   \
    test_rem_two_tags_comma             \
    test_rem_two_tags_comma_short


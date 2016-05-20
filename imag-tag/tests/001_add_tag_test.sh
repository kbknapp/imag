#!/usr/bin/env bash

source $(dirname ${BASH_SOURCE[0]})/../../tests/utils.sh
source $(dirname ${BASH_SOURCE[0]})/utils.sh

test_add_tag() {
    local id="test"
    mk_store_entry_with_tags $id
    imag-tag --id $id --add foo
    entry_has_tag $id foo
}

test_add_tags_space() {
    local id="test"
    mk_store_entry_with_tags $id
    imag-tag --id $id --add foo bar

    entry_has_tag $id foo && \
    entry_has_tag $id bar
}

test_add_tags_comma() {
    local id="test"
    mk_store_entry_with_tags $id
    imag-tag --id $id --add foo,bar

    entry_has_tag $id foo && \
    entry_has_tag $id bar
}

test_add_tags_multi() {
    local id="test"
    mk_store_entry_with_tags $id
    imag-tag --id $id --add foo --add bar

    entry_has_tag $id foo && \
    entry_has_tag $id bar
}

test_add_tags_multi_short() {
    local id="test"
    mk_store_entry_with_tags $id
    imag-tag --id $id -a foo -a bar

    entry_has_tag $id foo && \
    entry_has_tag $id bar
}

test_add_tags_multi_short_combined() {
    local id="test"
    mk_store_entry_with_tags $id
    imag-tag --id $id -a foo -a bar,baz

    entry_has_tag $id foo && \
    entry_has_tag $id bar && \
    entry_has_tag $id baz
}

invoke_tests                            \
    test_add_tag                        \
    test_add_tags_space                 \
    test_add_tags_comma                 \
    test_add_tags_multi                 \
    test_add_tags_multi_short           \
    test_add_tags_multi_short_combined


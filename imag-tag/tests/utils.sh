source $(dirname ${BASH_SOURCE[0]})/../tests/utils.sh

imag-tag() {
    imag-call-binary "$(dirname ${BASH_SOURCE[0]})/../target/debug/" imag-tag $*
}

mk_store_entry_with_tags() {
    local name=$1; shift;
    local tags=$*;
    local file="${STORE}/$name"

    print_default_entry_header_open             >> $file
    echo -n 'tags = [ '                         >> $file
    for tag in $tags; do echo -n "'$tag'"; done >> $file
    echo -n ']'                                 >> $file
    print_default_entry_header_close            >> $file
}

entry_has_tag() {
    cat $1 | grep "tags = \[" | grep $2
}

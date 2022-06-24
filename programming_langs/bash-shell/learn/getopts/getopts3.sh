#!/bin/bash
unset VERBOSE
while getopts 'smv' c; do
    echo "Processing $c : OPTIND is $OPTIND"
    case $c in
        s) ACTION=sha1sum ;;
        m) ACTION=md5sum ;;
        v) VERBOSE=true ;;
    esac
done

echo "Out of the getopts loop. OPTIND is now $OPTIND"
shift $((OPTIND - 1))
if [ $VERBOSE ]; then
    set -x
fi
$ACTION $@

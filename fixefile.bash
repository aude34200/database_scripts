#!/bin/bash

function usage() {
    echo "Usage:"
    echo "$0 <filename>"
}

if [[ $# -ne 1 ]]; then
    echo "Error, you need to give the name of the file to convert."
    usage
    exit -1
fi

if [[ ! -f $1 ]]; then
    echo "Error, the name provided is not a valid filename."
    usage
    exit -1
fi

newfilename=$1.fixed

cat $1 | tr -d '\n' | sed 's/>sp/\n&/g' | sed 's/>tr/\n&/g' > $newfilename

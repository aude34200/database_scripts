#!/bin/bash

function usage() {
	echo "$0 <name_of_file_to_change>"
}

if [[ $# -lt 1 ]]; then
	echo "Error, you need to give a filename as argument."
	usage
	exit -1
fi

filename=$1
if [[ ! -f $filename ]]; then
	echo "Error: invalid filename $0"
	usage
	exit -1
fi

newfilename=$filename".new.txt" 
if [[ -f $newfilename ]]; then
	rm $newfilename
fi

while read line; do
    if [[ $line == \>Pp* ]]; then
        newline=`echo $line | awk '{a=$1; b=$2; c=$3; d=$4; e=$5; f=$6; g=$7; for(i=8;i<=NF;i++){g=g" "$i}; print a"|"b" "c" "d" "e" "f"|"g}' | sed 's/\r/|\r/g'`
    else
        newline=$line
    fi
    echo $newline >> $newfilename
done < $filename

sed -i '/^\s*$/d' $newfilename

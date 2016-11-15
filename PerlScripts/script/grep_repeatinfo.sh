#!/bin/bash

while IFS='' read -r line || [[ -n "$line" ]]; do
    echo $line
#    echo "Text read from file: $line"
    grep $line tuatara_repeat.map > "$line".repeat.map
done < "$1"

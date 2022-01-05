#!/bin/bash
# display command line options
# add one more commit because previous was merged

count=1
while [[ -n "$1" ]]; do
    echo "Parameter #$count = $1"
    count=$(( $count + 1 ))
    shift
done
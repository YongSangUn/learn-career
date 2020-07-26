#!/bin/bash

triangle() {
    local n=$1

    for ((i = $n; i >= 1; i--)); do
        middle=$((($n - $i) * 2))
        if [ $i -ne 1 ]; then
            left=$(($i - 1))
            printf "%${left}s/%${middle}s\\"
        else
            printf "/"
            printf "%${middle}s" | sed 's/ /_/g'
            printf "\\"
        fi
        printf "\n"
    done
}

#!/bin/bash

if [ -z $1 ]; then
    echo "Usage: sh get_bibitem.sh INSPIRENUMBER"
    exit
fi

curl -s https://inspirehep.net/record/$1/export/hlxu | sed -n '/\\cite/,/citations/p' | sed 's/<br>/\n/g' | sed 's/&nbsp;/\ /g'

#!/bin/bash

if [ -z $1 ]; then
    echo "Usage: sh get_bibitem.sh arXivNumber"
    exit
fi

BIBTEXURL=$(curl -s "https://inspirehep.net/search?ln=en&p=$1&of=hb&action_search=Search&sf=earliestdate&so=d" | grep "LaTeX(US)")
BIBTEXURLTMP1=${BIBTEXURL/'| <a href="https://inspirehep.net/record/'/}
BIBTEXURL=${BIBTEXURLTMP1/'/export/hlxu">LaTeX(US)</a>'/}
BIBTEXURL=$(echo ${BIBTEXURL} | tr -d ' ') # Don't know why but there is a stupid blank in front
curl -s https://inspirehep.net/record/${BIBTEXURL}/export/hlxu | sed -n '/\\cite/,/citations/p' | sed 's/<br>/\n/g' | sed 's/&nbsp;/\ /g'

#!/bin/bash

quotesource='http://www.quotedb.com/quote/quote.php?action=random_quote&c[126]=126'

curl -s -g "${quotesource}" |sed -e :a -e 's/<[^>]*>//g;/</N;//ba' | \
    sed -e s/document.write\(\'//g | \
    sed -e s/\'\)\;//g | \
    sed 's/More quotes from /  -- /g'| \
    sed '$!N;s/\n/ /'
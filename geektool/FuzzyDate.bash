#!/bin/bash
# converts exact date to fuzzy format
 
export day=$(date '+%d')
case $day in
01) export fuzzy_day='First';;
02) export fuzzy_day='Second';;
03) export fuzzy_day='Third';;
04) export fuzzy_day='Fourth';;
05) export fuzzy_day='Fifth';;
06) export fuzzy_day='Sixth';;
07) export fuzzy_day='Seventh';;
08) export fuzzy_day='Eighth';;
09) export fuzzy_day='Ninth';;
10) export fuzzy_day='Tenth';;
11) export fuzzy_day='Eleventh';;
12) export fuzzy_day='Twelth';;
13) export fuzzy_day='Thirteenth';;
14) export fuzzy_day='Fourteenth';;
15) export fuzzy_day='Fifteenth';;
16) export fuzzy_day='Sixteenth';;
17) export fuzzy_day='Seventeenth';;
18) export fuzzy_day='Eighteenth';;
19) export fuzzy_day='Nineteenth';;
20) export fuzzy_day='Twentieth';;
21) export fuzzy_day='Twenty-first';;
22) export fuzzy_day='Twenty-second';;
23) export fuzzy_day='Twenty-third';;
24) export fuzzy_day='Twenty-fourth';;
25) export fuzzy_day='Twenty-fifth';;
26) export fuzzy_day='Twenty-sixth';;
27) export fuzzy_day='Twenty-seventh';;
28) export fuzzy_day='Twenty-eighth';;
29) export fuzzy_day='Twenty-ninth';;
30) export fuzzy_day='Thirtieth';;
31) export fuzzy_day='Thirty-first';;
esac
echo $fuzzy_day
exit 0
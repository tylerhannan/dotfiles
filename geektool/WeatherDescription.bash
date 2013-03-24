#!/bin/bash
####### Denver #######
curl --silent "http://weather.yahooapis.com/forecastrss?w=2391279" | grep -E '(Current Conditions:|F<BR)' | sed -e 's/Current Conditions://' -e 's/<br \/>//' -e 's/<b>//' -e 's/<\/b>//' -e 's/<BR \/>//' -e 's/<description>//' -e 's/<\/description>//'
#
####### Evergreen #######
# curl --silent "http://weather.yahooapis.com/forecastrss?w=2400904" | grep -E '(Current Conditions:|F<BR)' | sed -e 's/Current Conditions://' -e 's/<br \/>//' -e 's/<b>//' -e 's/<\/b>//' -e 's/<BR \/>//' -e 's/<description>//' -e 's/<\/description>//'
#
####### Glenwood Springs #######
# curl --silent "http://weather.yahooapis.com/forecastrss?w=2411457" | grep -E '(Current Conditions:|F<BR)' | sed -e 's/Current Conditions://' -e 's/<br \/>//' -e 's/<b>//' -e 's/<\/b>//' -e 's/<BR \/>//' -e 's/<description>//' -e 's/<\/description>//'
#
####### Orlando #######
# curl --silent "http://weather.yahooapis.com/forecastrss?w=2459115" | grep -E '(Current Conditions:|F<BR)' | sed -e 's/Current Conditions://' -e 's/<br \/>//' -e 's/<b>//' -e 's/<\/b>//' -e 's/<BR \/>//' -e 's/<description>//' -e 's/<\/description>//'
#
####### New York #######
# curl --silent "http://weather.yahooapis.com/forecastrss?w=2459115" | grep -E '(Current Conditions:|F<BR)' | sed -e 's/Current Conditions://' -e 's/<br \/>//' -e 's/<b>//' -e 's/<\/b>//' -e 's/<BR \/>//' -e 's/<description>//' -e 's/<\/description>//'
#
####### San Francisco #######
# curl --silent "http://weather.yahooapis.com/forecastrss?w=2487956" | grep -E '(Current Conditions:|F<BR)' | sed -e 's/Current Conditions://' -e 's/<br \/>//' -e 's/<b>//' -e 's/<\/b>//' -e 's/<BR \/>//' -e 's/<description>//' -e 's/<\/description>//'
#
####### Seattle #######
# curl --silent "http://weather.yahooapis.com/forecastrss?w=2490383" | grep -E '(Current Conditions:|F<BR)' | sed -e 's/Current Conditions://' -e 's/<br \/>//' -e 's/<b>//' -e 's/<\/b>//' -e 's/<BR \/>//' -e 's/<description>//' -e 's/<\/description>//'
#
####### Washington DC #######
# curl --silent "http://weather.yahooapis.com/forecastrss?w=2514815" | grep -E '(Current Conditions:|F<BR)' | sed -e 's/Current Conditions://' -e 's/<br \/>//' -e 's/<b>//' -e 's/<\/b>//' -e 's/<BR \/>//' -e 's/<description>//' -e 's/<\/description>//'
#
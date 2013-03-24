#!/bin/bash
####### Denver #######
curl --silent "http://weather.yahoo.com/united-states/colorado/denver-12792942/" | grep "current-weather" | sed "s/.*background\:url(\'\(.*\)\') .*/\1/" | xargs curl --silent -o /tmp/weather.png
#
####### Evergreen #######
# curl --silent "http://weather.yahoo.com/united-states/colorado/evergreen-2400904/" | grep "current-weather" | sed "s/.*background\:url(\'\(.*\)\') .*/\1/" | xargs curl --silent -o /tmp/weather.png
#
####### Glenwood Springs #######
# curl --silent "http://weather.yahoo.com/united-states/colorado/glenwood-springs-2411457/" | grep "current-weather" | sed "s/.*background\:url(\'\(.*\)\') .*/\1/" | xargs curl --silent -o /tmp/weather.png
#
####### New York #######
# curl --silent "http://weather.yahoo.com/united-states/new-york/new-york-2459115/" | grep "current-weather" | sed "s/.*background\:url(\'\(.*\)\') .*/\1/" | xargs curl --silent -o /tmp/weather.png
#
####### Orlando #######
# curl --silent "http://weather.yahoo.com/united-states/new-york/new-york-2459115/" | grep "current-weather" | sed "s/.*background\:url(\'\(.*\)\') .*/\1/" | xargs curl --silent -o /tmp/weather.png
#
####### San Francisco #######
# curl --silent "http://weather.yahoo.com/united-states/california/san-francisco-2487956/" | grep "current-weather" | sed "s/.*background\:url(\'\(.*\)\') .*/\1/" | xargs curl --silent -o /tmp/weather.png
#
####### Seattle #######
# curl --silent "http://weather.yahoo.com/united-states/washington/seattle-2490383/" | grep "current-weather" | sed "s/.*background\:url(\'\(.*\)\') .*/\1/" | xargs curl --silent -o /tmp/weather.png
#
####### Washington DC #######
# curl --silent "http://weather.yahoo.com/united-states/district-of-columbia/washington-2514815/" | grep "current-weather" | sed "s/.*background\:url(\'\(.*\)\') .*/\1/" | xargs curl --silent -o /tmp/weather.png
#

#!/bin/bash
asusctl profile -n
profile=$(asusctl profile -p | awk '{print $NF}')
dunstify "Profile: $profile" -t 800 -r 91160

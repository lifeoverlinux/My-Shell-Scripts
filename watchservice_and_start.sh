#!/bin/bash
# Author: Ibrahim Ucar
# Written in: Debian 9.x
# Date: 19.10.2018
# Mail: ucribrahim@gmail.com

# -------ABOUT THIS SCRIPT------- #

# This script watches a (e.g. Firefox) service if process of the service stops then script start the service and also script
# make sure that service started. This script just an example, you can watch any services or configure as you wish.

# You can set this script to CRON to make this script works every minute, hour, day, etc.


# Get the process of the "firefox" service.
pid=$(ps -e | pgrep firefox | wc -l | xargs echo -n)

# Simple echo massage.
echo "I'm checking the process of (Firefox Web Browser)... Please wait a second."

# IF conditions.
if [ $pid -eq 0 ]; then
        echo
        echo "Firefox process doesn't exist. It means Firefox is not working!"
        echo
        echo "Firefox starting..."
        sh /usr/bin/firefox &

        echo
        pid1=$(ps -e | pgrep firefox | wc -l | xargs echo -n)
        if [ $pid1 -ne 0 ]; then
        echo "Firefox has been started. I checked the process now, it's working."
        else
        echo "Firefox couldn't be started!"
        fi
else
        echo
        echo "The process of ( Firefox Web Browser ) exist! It means Firefox service working."
fi

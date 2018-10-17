#!/bin/bash
# Author: Ibrahim Ucar
# Written in: Debian
# Mail: ucribrahim@gmail.com

# --- ABOUT THIS SCRIPT ---

# This script watches a service process if the process of service stops then script sends an email to the user that
# let the user know that a service (e.g. Firefox) stopped. This script just an example, you can watch any services or
# configure as you wish.

# You can set this script to CRON to make this script works every minute, hour, day, etc.

# --- STEPS --- 
# FIRST: Install "ssmtp" service and then configure it. Make sure that you can send mail with "ssmtp" command line.
# SECOND: Define a mail address to the downline. Otherwise script will not send e-mail! 

email="username@domain.com"

# Get the process of the "firefox" service.
pid=$(ps -e | pgrep firefox | wc -l | xargs echo -n)

# Simple echo massage.
echo "I'm checking the process of (Firefox Web Browser)... Please wait a second."

# Here, I'm checking the variable that if process equal to "0" number or not equal. 
if [ $pid -eq 0 ]; then
        echo
        echo "Firefox process doesn't exist. I'm sending an e-mail to the user."
        echo "Firefox process doesn't exist. This is a warning message that Firefox service stopped." | ssmtp $email

else
        echo
        echo "The process of ( Firefox Web Browser ) exist! It means Firefox service working."
fi

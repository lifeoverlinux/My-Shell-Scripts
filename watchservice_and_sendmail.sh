#!/bin/bash
# Author: Ibrahim Ucar
# Written in: Debian
# Mail: ucribrahim@gmail.com

# This script watches a service process if the process of service stops then script sends an email to the user that
# let the user know that a service (e.g. Firefox) stopped. This script just an example, you can watch any services or
# configure as you wish.

# You can set this script to CRON to make this script works every second, minute, hour, etc.


# Define user mail address to the downline. You also need to configure "ssmtp" service in your system.
# Otherwise script will not be able to send e-mail!

email="username@domain.com"

# Rest of the shell script commands.

pid=$(ps -e | pgrep firefox | wc -l | xargs echo -n)

echo "I'm checking the process of (Firefox Web Browser)... Please wait a second."

if [ $pid -eq 0 ]; then
        echo
        echo "Firefox process doesn't exist. I'm sending an e-mail to the user."
        echo "Firefox process doesn't exist. This is a warning message that Firefox service stopped." | ssmtp $email

else
        echo
        echo "The process of ( Firefox Web Browser ) exist! It means Firefox service working."
fi


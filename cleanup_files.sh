#!/bin/bash
# Author: Ibrahim Ucar
# Written in: Debian 9
# Date: 29.10.2018
# Mail: ucribrahim@gmail.com

# This shell script automatically clean up files that you defined down into the variables. It's basic clean up script.
# You can set this script to CRON to make this script works every minute, hour, day, etc.


# Variables of this shell script. Define your paths of log files that will be clean up!

file1="/var/log/mylog1.txt"
file2="/var/log/mylog2.txt"
file3="/var/log/mylog3.txt"

#--------------------------------------------------------------
# We will let the "root" user execute this script. Other users will not be allowed to execute this script.
# If this feature needed then remove the "#" signs which start at the beginning of the lines.
#USERID=$(echo $UID)
#
#if [ $USERID -eq "0" ]; then
#       echo "---------------------------------"
#       echo "You're root. Let the boss go on!"
#       echo "---------------------------------"
#       else
#       echo "You're not root. This script can be only executed by root user!"
#       exit
#fi
#---------------------------------------------------------------

# Cleanup process. There is if condititon for three(3) files in the variables above.

if [ -f $file1 ]; then
        cat /dev/null > $file1
        echo "$file1 has been cleaned!"
        else
        echo "$file1 doesn't exists!"
fi


if [ -f $file2 ]; then
        cat /dev/null > $file2
        echo "$file2 has been cleaned!"
        else
        echo "$file2 doesn't exists!"
fi


if [ -f $file3 ]; then
        cat /dev/null > $file3
        echo "$file3 has been cleaned!"
        else
        echo "$file3 doesn't exists!"
fi

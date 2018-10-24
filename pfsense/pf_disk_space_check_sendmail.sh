#!/bin/sh
# Author: Ibrahim Ucar
# Written in: pfSense 2.4.4
# Date: 23.10.2018
# Mail: ucribrahim@gmail.com


# This script watches the disk given by user and when disk being greater than "90%" that I send mail to user.
# Well, before system crash, Admin will be aware that he should work to make available disk space.

# You can set this script to CRON to make this script works every minute, hour, day, etc.


# ------------IMPORTANT------------- #

# Please write the name of the disk which disk or partition has been mounted to ( "/" ).
# Use "df -h" command to see which disk mounted to ( "/" ) and then write disk name into the variable..

# For example, for me I will write "/dev/sda1" into the variable.
# EXAMPLE: Filesystem      Size  Used Avail Use% Mounted on
# EXAMPLE: /dev/sda1        20G  3.2G   15G  18% /

diskname="/dev/sda1"

# ------------IMPORTANT------------- #


# Necessary file for this script get to work.
touch /tmp/email_diskusage.txt
MAILFILE=/tmp/email_diskusage.txt


# Rest of the shell script commands.

df -H | grep "$diskname" | awk '{ print $5}' > /tmp/diskuse.txt
usage=$(cat /tmp/diskuse.txt | cut -f1 -d\%)

if [ $usage -ge 90 ]; then
        echo "WARNING! Your disk running out of space. The usage greater than 90%!. I sent an email to user."
  	php -f /root/mailsender.php
fi

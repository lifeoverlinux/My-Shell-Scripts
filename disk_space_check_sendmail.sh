#!/bin/bash
# Author: Ibrahim Ucar
# Written in: Centos Server 7  ( It should work GNU/Linux and FreeBSD based systems)
# Date: 25.10.2018
# Mail: ucribrahim@gmail.com


# This script watches the disk given by user and when disk being greater than "90%" that I send mail to user.
# Well, before system crash, Admin will be aware that he/she should work to make disk available space on it.

# You can set this script to CRON to make this script works every minute, hour, day, etc.



# ------------IMPORTANT------------- #

# Please write the name of the disk which disk or partition has been mounted to ( "/" ).
# Use "df -h" command to see which disk mounted to ( "/" ) and then write disk name into the variable..

# For example, for me I will write "/dev/sda1" into the variable.
# EXAMPLE: Filesystem      Size  Used Avail Use% Mounted on
# EXAMPLE: /dev/sda1        20G  3.2G   15G  18% /

diskname="/dev/sda1"

# ------------IMPORTANT------------- #


# ***** Requirements! *****
# Install "Ssmtp" and configure it.


# Which mail that the warning message will be send when disk greater than 90%.
email="username@domain.com"


# I create a file which includes messages to send user. When my job finished about file then I delete the file.
touch /tmp/email_diskusage.txt
MAILFILE=/tmp/email_diskusage.txt


# Rest of the shell script commands.

df -H | grep "$diskname" | awk '{ print $5}' > /tmp/diskuse.txt
usage=$(cat /tmp/diskuse.txt | cut -f1 -d\%)

if [ $usage -ge 90 ]; then
        echo "WARNING! Your disk running out of space. The usage greater than 90%!. I sent an email to $email address."
        echo "Subject:WARNING: Disk Capaticy 90%" > $MAILFILE
        echo "To: $email" >> $MAILFILE
        echo "From: $email" >> $MAILFILE

        echo "" >> $MAILFILE
        echo "Disk running out of space. Currently disk usage $usage% on $(hostname) as on $(date '+%Y/%m/%d at %H:%M:%S'). Do not forget to check disk space on server before system crash." >> $MAILFILE
        echo "" >> $MAILFILE
        echo "Have a nice day!" >> $MAILFILE
        cat $MAILFILE | ssmtp $email
fi
rm $MAILFILE

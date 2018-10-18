#!/bin/bash
# Author: Ibrahim Ucar
# Written in: Debian
# Mail: ucribrahim@gmail.com


# This script backup files of a directory and then send the (backup.tar.gz) file to the user with email.
# This script just an example, you can configure as you wish.

# You can set this script to CRON to make this script works every minute, hour, day, etc.


# Variables of this shell script.

hostname=$(hostname)
date=$(date '+%Y-%m-%d %H:%M:%S')
# Write the path where your files include for backup.
backup_files="/home/my_logs"
# Write the path where backed up files will be stored.
check_dest="/home/backups"
dest="/home/backups/backups.tar.gz"
# Write e-mail address of the user.
email="username@domain.com"

# Create the directory which we will use this directory as a backup place. If it's not exist, create.

if [ ! -d $check_dest ]
    then
        mkdir $check_dest
        echo "$check_dest has been created."
        echo
    fi

# Rest of the shell script commands.

if [ -d $backup_files ]; then
        echo "$backup_files directory exists, looking for other neccesary directory..."
        if [ -d $check_dest ]; then
        echo "------------"
        echo "$check_dest directory exists, that means it's ready to backup files with (tar) command."

        else
        echo "$check_dest directory doesn't exists, that means it's NOT ready to backup files with (tar) command."
        fi
else
        echo "$backup_files directory doesn't exists, that means it's NOT ready to backup files with (tar) command."
fi

echo

echo "Please wait while getting backup files of this directory: $backup_files"
echo

# The commands for backup the files.

cd $backup_files
PWD=$(pwd)

if [[ $PWD/ = $backup_files/ ]]; then

tar cvzf $dest *
echo
echo "Tar process has been finished. Now I will send the $dest file to the user with mail."

else

echo "You're not in right directory which is $backup_files"

fi

# The commands for send "backup.tar.gz" file to user with e-mail.

if [ -f $dest ]; then
        echo "This is a message from $hostname server on $date that $backup_files has been backed up and send you the $dest fi$
        mpack -s "Backup Message From Server" -d /tmp/message_body.txt $dest $email 2> /tmp/mail_err.txt

        if [ -s "/tmp/mail_err.txt" ]; then
        echo "Mail could not send!"
        echo "You can read the error from ( /var/log/mail.err ) file."
        else
        echo "Mail sent successfully."
        echo "You can see details of commands outputs in ( /var/log/syslog ) file."
        fi
else
        echo "The $dest file DOES NOT exists! Please review the shell script or check out at the beginning directories."
fi
rm -rf /tmp/mail_err.txt

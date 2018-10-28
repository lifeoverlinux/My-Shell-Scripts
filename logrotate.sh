#!/bin/bash
# Author: Ibrahim Ucar
# Written in: Centos 7
# Date: 25.10.2018
# Mail: ucribrahim@gmail.com

# This script backup (tar.gz) two files in this scenerio. After backed up two files, script will clean the inside of
# two files if succesfuly backed up.

# You can set this script to CRON to make this script works every minute, hour, day, etc.


# Get current date.
date=$(date "+%Y%m%d-%H:%M")

# Where are the log files in? (directory)
directory="/var/log/myxservice"

# Log files name (e.g. for this scenerio two files) IF you need to add more than two files, then create other codes - 
# (copy/paste) for your new files.

file1name=("mylog1.txt")
file2name=("mylog2.txt")

# The directory where the log files (tar.gz) are going to be keep in.
backup_directory="/var/log/myxservice/backups"

# If backup directory doesn't exists, then create. If already created then go on.

if [ ! -d $backup_directory ]; then
	mkdir $backup_directory
        echo "----------------------------------------------"
	echo "$backup_directory has been created!"
	echo "----------------------------------------------"
fi


# Log rotate process(1). There is "if" and "for" condititons for N files in the variables above.

cd $directory
PWD=$(pwd)

if [[ $PWD/ = $directory/ ]]; then
        [ ! -f $file1name ] && { echo "Opps! The file $file1name could not found! Check $directory directory!"; exit 1; }
        tar cvfz ${backup_directory}/${file1name}.${date}.tar.gz $file1name 2> /tmp/error.log
        if [ $? -ne 0 ]
        then
	echo "An error occurred while making a backup, see /tmp/error.log file."
        exit 3
	fi
	cat /dev/null > $file1name
        echo "$file1name has been cleaned! Date: $date. You can find backed up files in $backup_directory"
        rm /tmp/error.log
fi

# Log rotate process(2). There is "if" and "for" condititons for N files in the variables above.

cd $directory
PWD=$(pwd)

if [[ $PWD/ = $directory/ ]]; then
        [ ! -f $file2name ] && { echo "Opps! The file $file2name could not found! Check $directory directory!"; exit 1; }
        tar cvfz ${backup_directory}/${file2name}.${date}.tar.gz $file2name 2> /tmp/error.log
        if [ $? -ne 0 ]
        then
	echo "An error occurred while making a backup, see /tmp/error.log file".
        exit 3
	fi
	cat /dev/null > $file2name
	echo "$file2name has been cleaned! Date: $date. You can find backed up files in $backup_directory"
        rm /tmp/error.log
fi

exit 0

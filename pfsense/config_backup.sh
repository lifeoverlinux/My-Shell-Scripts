#!/bin/sh

# Get current date.
date=$(date "+%Y%m%d-%H:%M")

# Where are the log files in? (directory)
directory="/cf/conf"

# Log file name.
file1name="config.xml"

# The directory where the log files (tar.gz) are going to be keep in.
backup_directory="/cf/conf/config_backups"

# If backup directory doesn't exists, then create. If already created then go on.

if [ ! -d $backup_directory ]; then
        mkdir $backup_directory
        echo "----------------------------------------------"
        echo "$backup_directory has been created!"
        echo "----------------------------------------------"
fi

# Config.xml backup process.

cd $directory
PWD=$(pwd)

if [ $PWD/ = $directory/ ]; then
        [ ! -f $file1name ] && { echo "Opps! The file $file1name could not found! Check $directory directory!"; exit 1; }
        tar cvfz ${backup_directory}/${file1name}.${date}.tar.gz $file1name 2> /tmp/error.log
        if [ $? -ne 0 ]
        then
        echo "An error occurred while making a backup, see /tmp/error.log file."
        exit 3
        else
        echo "$file1name has been backed up to $backup_directory directory on $date"
        fi
fi


# The files which older than 5 days will be deleted. 
# The following value can be changed, it depends on how often you run this script for backup.

find $backup_directory -type f -name "*.tar.gz" -mtime +5 -exec rm {} \;

exit 0

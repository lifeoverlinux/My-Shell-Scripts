#!/bin/sh
# Author: Ibrahim Ucar
# Written in: pfSense 2.4.4
# Date: 10.11.2018
# Mail: ucribrahim@gmail.com

# Get the date. Year-Month,Day
DATE=`date "+%Y%m%d"`


# ---------ABOUT THE SCRIPT-----------

# This script will send some files automatically in a directory to another client's directory securely over ssh via ssh keys.


# You will have to use the following two commands only once. No need to use them second time! Just copy&paste commands.

# ssh-keygen -f /root/.ssh/id_rsa -t rsa -N ""
# ssh-copy-id -i /root/.ssh/id_rsa.pub root@192.168.1.100    # change ip address!



# ----- After you used all above commands then you can run the script. -----


# Another script in my system backup some files into the /root/logs directory with today's date via tar command and this script will send today's files to the client.

for file in $(find /root/logs -type f | egrep "$DATE"); do scp $file root@192.168.1.100:/root/backups/; done;

exit 0

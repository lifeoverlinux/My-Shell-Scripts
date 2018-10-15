## watchservice.sh

#!/bin/bash
#Author: Ibrahim Ucar
#Mail: ucribrahim@gmail.com
#Website: lifeoverlinux.com

#-- About this script.
#-- This script watch a service process, if the process of service stops then script sends a email to the user -
#-- that let the user know that a service (e.g firefox) stopped. This script just an example, you can watch any services.

#-- You can set this script to CRON to make this script works every minute, second, hour, etc.


# Mail information of users. As you defined the following mail address, you also need to configure ssmtp service.
# Otherwise you'll not be able to send mail!

email="username@domain.com"

# Rest of shell script commands.

pid=$(ps -e | pgrep firefox | wc -l | xargs echo -n)

echo "I'm checking the process of (Firefox Web Browser)... Please wait a second."

if [ $pid -eq 0 ]; then
        echo
        echo "Firefox process doesn't exist. Sending e-mail to the user."
        echo "Firefox process doesn't exist. This is a information that Firefox service stopped." | ssmtp $email

else
        echo
        echo "The process of ( Firefox Web Browser ) exist! It means firefox still working."
fi


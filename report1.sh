#!/bin/bash

# Name:         Thomas McLaughlin
# Project:      Bash Project 1
# Date:         4/10/2024
# File(s):      report1.sh / report1
# Description:  This bash script when run, will display relevant information about the user running the script.
#               This bash script acts as a report showing information about whoever is running the script.
#               This script will show the following information about the user's account:
#
#               - Username of the current user
#               - User's full name
#               - User's home directory
#               - User's shell
#               - User's password expiration date
#               - Last logins for user (last 10 by default, or whatever parameter provided)
#               - Uptime and users on the system
#               - Open TCP ports on the system
#               - Indicator of whether the web server is up and running



echo "" # Blank line for readability



#    Username Field
userName=$(whoami) #whoami displays the account you are currently logged into
echo "Information for user: $userName"
echo ""



#    Full name Field
userEntryData=$(cat /etc/passwd | grep $userName)

#          username:pass:UID:GID:Fullname:homeDir:shell
#             1    :  2 : 3 : 4 :   5    :   6   :  7

fullName=$(echo "$userEntryData" | cut -d ':' -f 5) # -f 5 because we want 5th column of data as shown above
echo "Full name: $fullName"
echo ""



#    Home directory Field
userEntryData=$(cat /etc/passwd | grep $userName)

#          username:pass:UID:GID:Fullname:homeDir:shell
#             1    :  2 : 3 : 4 :   5    :   6   :  7

homeDir=$(echo "$userEntryData" | cut -d ':' -f 6) # -f 6 because we want 6th column of data as shown above
echo "Home directory: $homeDir"
echo ""



#    Shell Field
userEntryData=$(cat /etc/passwd | grep $userName)

#          username:pass:UID:GID:Fullname:homeDir:shell
#             1    :  2 : 3 : 4 :   5    :   6   :  7

shell=$(echo "$userEntryData" | cut -d ':' -f 7) # -f 7 because we want 7th column of data as shown above
echo "Shell: $shell"
echo ""



#    Password expiration Field
passwordExpirationLine=$(chage -l $userName | grep "Password expires")

#           Password expires                               : Jun 12, 2024

passwordExpirationDate=$(echo "$passwordExpirationLine" | cut -d ':' -f 2) # -f because we want 2nd column of data as shown above
echo "Password expires: $passwordExpirationDate"
echo ""



#    Last login attempts for user Field
numberLastLogins=10

if [ $# -eq 1 ]
then
   numberLastLogins=$1 # setting numberLastLogins to parameter provided, if a parameter is provided
fi

echo "Last $numberLastLogins logins for $userName:"
loginData=$(last -$numberLastLogins $userName | grep -v "wtmp")
echo "$loginData"
echo ""
# using " | grep -v "wtmp" "to remove extra line that my script has that yours does not. 
# note to self, try "wtmp begins" if "wtmp" does not work


#    Uptime and users on this system Field
echo "Uptime and users on this system:" 
echo $(w)
echo ""



#    Open TCP ports Field
#output open tcp ports
echo "Open TCP ports:"
tcpOpenPortData=$(netstat -tan)
echo "$tcpOpenPortData"
echo ""



#    Web server up Field
webServerStatusLines=$(ps aux | grep httpd) # grep'ing lines with httpd

if echo "webServerStatusLines" | grep -q 'root'; then  # grep'ing again to see if there exists a subset of lines with root
    echo "The web server is running."
else
    echo "The web server is not running."
fi
echo ""

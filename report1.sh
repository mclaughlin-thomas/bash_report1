#!/bin/bash

# Name:         Thomas McLaughlin
# Project:      Bash Project 1+
# Date:         4/10/2024
# File(s):      report1.sh
# Description:  This bash script when run, will display relevant information about the user running the script.
#               This bash script acts as a report showing information about whoever is running the script.
#               This script will show the following information about the user's account:
#
#        X       - Username of the current user
#        X       - User's full name
#        X       - User's home directory
#        X       - User's shell
#        X       - User's password expiration date
#        X       - Last logins for user (last 10 by default, or whatever provided parameter)
#        X       - Uptime and users on the system
#        X       - Open TCP ports on the system
#        X       - Indicator of whether the web server is up and running


echo "" # Blank line for readability

#username
userName=$(whoami) 
# Could alternatively use: userName='whoami'

echo "Information for user: $userName"
echo ""
#username


#fullname
userEntryData=$(cat /etc/passwd | grep $userName)
#username:pass:UID:GID:Fullname:homeDir:shell
#   1    :  2 : 3 : 4 :   5    :   6   :  7

fullName=$(echo "$userEntryData" | cut -d ':' -f 5)
echo "Full name: $fullName"
echo ""
#fullname


#home dir
userEntryData=$(cat /etc/passwd | grep $userName)
#username:pass:UID:GID:Fullname:homeDir:shell
#   1    :  2 : 3 : 4 :   5    :   6   :  7

homeDir=$(echo "$userEntryData" | cut -d ':' -f 6)
echo "Home directory: $homeDir"
echo ""
#home dir


#Shell
userEntryData=$(cat /etc/passwd | grep $userName)
#username:pass:UID:GID:Fullname:homeDir:shell
#   1    :  2 : 3 : 4 :   5    :   6   :  7

shell=$(echo "$userEntryData" | cut -d ':' -f 7)
echo "Shell: $shell"
echo ""
#Shell


#password expiration
passwordExpirationLine=$(chage -l $userName | grep "Password expires")
#Password expires                                        : never

passwordExpirationDate=$(echo "$passwordExpirationLine" | cut -d ':' -f 2)
echo "Password expires: $passwordExpirationDate"
echo ""
#password expiration


#Last logins for user
numberLastLogins=10

if [ $# -eq 1 ]
then
   numberLastLogins=$1
fi

echo "Last $numberLastLogins logins for $userName:"
loginData=$(last -$numberLastLogins $userName)
echo "$loginData"
echo ""
#maybe do not include the wtmp data section. | grep -v "wtmp begins" at end of 85
##OpenLast logins for user


#Uptime and users on this system
echo "Uptime and users on this system:" 
echo $(w)
echo ""
#Uptime and users on this system


#Open TCP ports
#output open tcp ports
echo "Open TCP ports:"
tcpOpenPortData=$(netstat -tan)
echo "$tcpOpenPortData"

echo ""
#Open TCP ports



#webserver up
webServerStatusLines=$(ps aux | grep httpd)
# USER | PID | %CPU | %MEM | VSZ | RSS | TTY | STAT | START | TIME | COMMAND
# root |  1  |  0.0 |  0.0 |166652|12000| ?  |  Ss  | Apr11 | 0:01 | /sbin/init splash

if echo "webServerStatusLines" | grep -q 'root'; then
    echo "The web server IS running!"
else
    echo "The web server IS NOT running!"
fi
echo ""
#webserver up

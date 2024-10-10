#!/bin/bash

#  Title: Script to Manage User Accounts on Multiple Servers
#
#
#  Description: Bash script useful for Managing user accounts on
#               Multiple Linux Servers. The Script is capable of
#               Onboarding new user accounts, Modifying the
#               Existing user accounts, Deleting the user accounts.
#
#               The Servers on which the user accounts has to be managed
#               is placed in on file (One server in each line and can
#               include IP addresses as well)and will be passed as an
#               argument while running the script.
#
# Version:      1.0
# Author:       B Gopal
# Usage: ./usermanage.sh <Servers File>
#
# Note: While onboarding the new user, The user will be created with default
#       values and can be edited later through script

INVOPTION="echo -e '\033[0;31m Invalid Option ... Exiting \033[0m'"
echo -e "\n \033[0;35m Script to Manage User Accounts \033[0m \n \n \033[0;33m Note: While adding the new user it will be created with default values and can be edited later through script \033[0m \n"
read -p "Enter logon SSH user:" LOGONUSER
while true
do
   echo -e "\n \033[0;33m Enter the action to be performed: \033[0m \n 1) Add the user \n 2) Modify the user \n 3) Delete the user"
   read -p "Selection: " ACTION
   read -p "Enter the Username: " USERNAME
   if [[ $ACTION -eq 2 ]]
   then
      echo -e "\n \033[0;33m What operation you want to perform: \033[0m \n 1) Change user home directory \n 2) Change shell of the user \n 3) change uid of the user \n 4) change gid of the user \n 5) change primary group of the user \n 6) change secondary group of the user \n 7) Update GECOS's field "
      read -p "Selection: " ACTION2
      echo " "
      if [[ $ACTION2 -eq 1 ]]
      then
         read -p "Enter the home directory: " HOMEDIR
      elif [[ $ACTION2 -eq 2 ]]
      then
         read -p "Enter the shell of user: " USERSHELL
      elif [[ $ACTION2 -eq 3 ]]
      then
         read -p "Enter UID of user: " USERUID
      elif [[ $ACTION2 -eq 4 ]]
      then
         read -p "Enter GID of user: " USERGID
      elif [[ $ACTION2 -eq 5 ]]
      then
         read -p "Enter primary group: " PRIGROUP
      elif [[ $ACTION2 -eq 6 ]]
      then
         read -p "Enter Secondary group (ex: group1,group2): " SECGROUP
      elif [[ $ACTION2 -eq 7 ]]
      then
         read -p "Enter GECOS: " USERGECOS
      else
         $INVOPTION
         exit 1
      fi
   fi
   for SERVERS in $(cat $1)
   do
      HEAD="echo ==================== $SERVERS =============="
      STATUS="> /dev/null 2>&1 && echo -e '\033[0;32m Success \033[0m' || echo -e '\033[0;31m Failed \033[0m'"
      CONFAILMESG="echo -e \033[0;30m \033[41m Failed to connect to $SERVERS \033[0m \033[0m"
      case $ACTION in
      "1")
          $HEAD;ssh -q -l $LOGONUSER $SERVERS "useradd $USERNAME $STATUS" || $CONFAILMESG
          ;;
      "2")
          case $ACTION2 in
          "1")
              $HEAD;ssh -q -l $LOGONUSER $SERVERS "usermod -d $HOMEDIR $USERNAME $STATUS" || $CONFAILMESG
              ;;
          "2")
              $HEAD;ssh -q -l $LOGONUSER $SERVERS "usermod -s $USERSHELL $USERNAME $STATUS" || $CONFAILMESG
              ;;
          "3")
              $HEAD;ssh -q -l $LOGONUSER $SERVERS "usermod -u $USERUID $USERNAME $STATUS" || $CONFAILMESG
              ;;
          "4")
              $HEAD;ssh -q -l $LOGONUSER $SERVERS "usermod -g $USERGID $USERNAME $STATUS" || $CONFAILMESG
              ;;
          "5")
              $HEAD;ssh -q -l $LOGONUSER $SERVERS "usermod -g $PRIGROUP $USERNAME $STATUS" || $CONFAILMESG
              ;;
          "6")
              $HEAD;ssh -q -l $LOGONUSER $SERVERS "usermod -G $SECGROUP $USERNAME $STATUS" || $CONFAILMESG
              ;;
          "7")
              $HEAD;ssh -q -l $LOGONUSER $SERVERS "usermod -c "$USERGECOS" $USERNAME $STATUS" || $CONFAILMESG
              ;;
            *)
              $INVOPTION
              ;;
          esac
          ;;
      "3")
          $HEAD;ssh -q -l $LOGONUSER $SERVERS "userdel $USERNAME $STATUS" || $CONFAILMESG
          ;;
        *)
          $INVOPTION
          ;;
      esac
   done
done

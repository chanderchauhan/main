#!/bin/sh

while :
do
 clear
 echo "M A I N - M E N U"
 echo "1). Change Password."
 echo "2). See the disk Space"
 echo "3). Login to other unix system"
 echo "4). All Service running."
 echo "5). Open ports"
 echo "6). Java Apps Running"
 echo "7). Kill an Application"
 echo "8). Exit"
 echo -n "Please enter option [1-8]"
 read option

 if [ "$UID" = "0" ]
  then
  echo "Ok " 
 else
  echo "You should be root user to run the System admin information" 
  echo "By $USER  see you again " 
  exit 1
 fi
  
 case $option in 
  1) echo "Enter New Password";
     stty_orig=`/bin/stty -g`;
     /bin/stty -echo;
     read newpassword;
     /bin/stty "$stty_orig";
     echo "$USER:$newpassword"|"/usr/sbin/chpasswd";
     if [ $? = 0 ] 
     then
     echo "Password successfully changed for $USER"
     else
     echo "password not changed"
     fi;
     echo "Press Enter [enter] Key to continue";
     read enterKey;;
  2) echo " Disk Space";
     /bin/df|/bin/sed "1 d";    
     echo "	Press [enter] key to continue...";
     read enterKey;;
  3) echo "Enter the Remote System's name";
     read systemname;
     echo "Enter the Login name on Remote System";
     read loginname;
     echo "Enter the password for remote login id";
     stty_orig=`/bin/stty -g`;
     /bin/stty -echo;
     read remotepassword; 
     /bin/stty "$stty_orig";
     echo "Connecting , Pls Wait ..."
     (/usr/bin/ssh "$loginname":"$remotepassword"\@"$systemname"); 
     echo "Press Enter [enter] Key to continue";
     read enterKey;;
  4) echo "Services Running"; 
     /sbin/service --status-all|/bin/grep 'running'|more;
     echo "		Press [enter] key to continue...";
     read enterKey;;
  5) clear; 
     echo "Open ports";
     /bin/netstat -vatn|/bin/sed "1,2 d"|/bin/awk '{print $4}'|more;
     echo "     Press [enter] key to continue...";
     read enterkey;; 
  6) echo " Java Application Running on system";
     /usr/bin/pgrep -fl java;
     echo "		Press [enter] key to continue...";
     read enterKey;;
  7) echo "Kill an Application";
     echo "Enter the name of Application ";
     read applicationname;
     /usr/bin/killall -iI $applicationname;
     if [ "$?" = "0" ]
      then
      echo "The $applicationname was successfully killed"
      else
      echo "The $applicationname killing was not successful"
     fi;
     echo "		Press [enter] key to continue...";
     read enterKey;;    
  8) echo "Bye $USER, See you again !";
     exit 1;;
  *) echo "		$opt is an invalid option. Please select option between 1-8 only";
     echo "		Press [enter] key to continue...";
     read enterKey;;
 esac
done

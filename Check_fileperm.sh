#!/usr/bin/bash
#script to check the files with 777 permissions and send the list to the resoective users
#Display the header in excel file
echo Permission Owner Filepath | tr " " "," > tst.csv

#Read the directory details to check the perform the permission check on the files
read -p "Enter the directory to check the file permissions : "  Dir

#Check for the files with 777 permissions and get the details
f1=$(find $Dir -type f -perm 777 -ls | awk '{print $3, $5, $11}' | tr " " "," >> tst.csv)

#Display the values properly
f2=$(cat $Dir/tst.csv | tr "-" " " > Fileperm_violations.csv)

rm -rf $Dir/tst.csv

#Check for the files with 777 permissions and get the users
f3=$(find $Dir -type f -perm 777 -ls | awk '{print $5}' | uniq> mail_list.txt)

# To exclude any users in the mail
#f4=$(cat mail_list.txt | sed -e 's/\<<user to exclude from mail>\>//g')

chmod 755 $Dir/Fileperm_violations.csv

#Append the extension to the users listed with violation to trigger the mail, change the @abc.com to trigger the mail to respective users
MAIL_LIST=$(sed 's/$/<@abc.com>/' mail_list.txt)


echo -e "Hi All,\n\nPlease find the attached sheet with File permission violation and change the permissions accordingly.\n\nThanks" | mailx -s "File permission Violation" -a "$Dir/Fileperm_violations.csv" $MAIL_LIST

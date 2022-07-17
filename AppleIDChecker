#Remediation Code
#!/bin/bash
file=1.csv

users_list=$(cat "$file" |cut -d "," -f 4 | cut -d "@" -f 1)

host=$(hostname)

for user in $users_list 

do 

object=/Users/$user/Library/Application\ Support/iCloud/Accounts

if [ -d "$object" ];

then 

 id=$(ls "$object" | grep @)

 domain_name=$(echo $id | cut -d "@" -f2)
 if [ "$domain_name" != "domain1.com" ] && [ "$domain_name" != "domain2.com" ];

then 
echo "Sending notification"
token=''
chatid=""
subject="Automox Notification"
notification="AppleID of $user on $host is $id"

/usr/bin/curl -s -H 'Content-Type: application/json' -X 'POST' -d "{\"chat_id\":\"${chatid}\",\"text\":\"${subject}\n${notification}\"}" "https://api.telegram.org/bot${token}/sendMessage"

 fi  


else 
echo "AppleID is normal. There's nothing to do"
sleep 1

fi 
done

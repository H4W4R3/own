#!/bin/bash

banner()
{
  echo "+------------------------------------------+"
  printf "| %-40s |\n" "`date`"
  echo "|                                          |"
  printf "|`tput bold` %-40s `tput sgr0`\n" "$@"
  echo "+------------------------------------------+"
}

banner "Clear Como Files /T24/TAFJ/log_T24/como "


# Declare a string array
Monthes=("Jan"
"Feb"
"Mar"
"Apr"
"May"
"Jun"
"Jul"
"Aug"
"Sep"
"Oct"
"Nov"
"Dec")
inMonth=()
VALIEDMonthes=()

read -r -p "`tput bold` Please Enter Month Name  < Jan Oct Aug >: `tput sgr0`" -a inMonth


for M in "${inMonth[@]}"; do 

	if [[ $(echo ${Monthes[@]} | fgrep -w $M) ]]
		then
		  VALIEDMonthes+=($M)
		else
		  echo " ($M) Not VALIED"
	fi
	   
done



echo " "

AllMnth="VALIED Values "

for mnth in "${VALIEDMonthes[@]}"; do 
 AllMnth+=$mnth" "
done

banner "{ $AllMnth } &  COMO "

echo "`tput bold` All COMO Size"
ls -ltr "/T24/TAFJ/log_T24/como" | wc -l  | tee -a count
echo "`tput sgr0`"




echo " "
read -p "`tput bold`  Do you want to remove COMO files? < Y / N > `tput sgr0`" prompt
echo " "


if [[ $prompt == "y" || $prompt == "Y" || $prompt == "yes" || $prompt == "Yes" ]]
then

for months in "${VALIEDMonthes[@]}"; do 

ls  -ltr "/T24/TAFJ/log_T24/como" | grep "$months"  | awk -F "$months"  '{print $2}' | awk -F ' ' '{print $3}' >> $months.txt


split -b 500k $months.txt "$months._"





 for i in $(ls $months._*) ; do
   
    sleep 1
   while read -r line
	do

	  rm "/T24/TAFJ/log_T24/como/$line"
	 
	  
	done < "$i"
   

done
 
  echo "`tput bold`"
   
  wc -l  $months.txt | tee -a count
  ls $months._* | tee -a count

  echo "`tput sgr0`"
  
 sleep 1
  
  
done

else
  exit 0
fi

echo "`tput bold` All COMO Size"
ls -ltr "/T24/TAFJ/log_T24/como" | wc -l  | tee -a count
echo "`tput sgr0`"


banner "Finished"

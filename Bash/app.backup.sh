#!/bin/bash


banner()
{
  echo "+------------------------------------------+"
  printf "| %-40s |\n" "`date`"
  echo "|                                          |"
  printf "|`tput bold` %-40s `tput sgr0`|\n" "$@"
  echo "+------------------------------------------+"
}

echo " "
banner "APPLICATION BACK-UP"
echo " "

read -p "`tput bold`  BACK-UP FOR SIT/UAT ? `tput sgr0`" AreaName


echo " "
read -p "`tput bold
`  START TO TAKE BACK-UP? < Y / N > `tput sgr0`" prompt
echo " "


currentDate="$(date '+%Y.%m.%d_%H-%M-%S')"

if [[ $prompt == "y" || $prompt == "Y" || $prompt == "yes" || $prompt == "Yes" ]]
then




if [[ $AreaName == "SIT"|| $AreaName == "sit" ]]
then


cd /T24 
tar -cvf 'bnk.'$currentDate.tar  '/T24/bnk'
gzip 'bnk.'$currentDate.tar 

tar -cvf 'TAFJ.'$currentDate.tar '/T24/TAFJ'
gzip 'TAFJ.'$currentDate.tar



elif [[ $AreaName == "UAT"|| $AreaName == "uat" ]]
then

cd /T24 
tar -cvf 'bnk.'$currentDate.tar  '/T24/bnk'
gzip 'bnk.'$currentDate.tar 

tar -cvf 'TAFJ.'$currentDate.tar '/T24/TAFJ'
gzip 'TAFJ.'$currentDate.tar

tar -cvf 'UD.'$currentDate.tar '/nfs/T24/shared/UD'
gzip 'UD.'$currentDate.tar


else
echo 'Invalid Input'

  exit 0
fi


echo " "
banner "BACK-UP HAS BEEN TAKEN"
echo " "

else
  exit 0
fi

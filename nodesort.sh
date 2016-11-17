#!/bin/bash~

#Requests name of input file
echo -n "Name of node file you would like to sort?"
read NODE

#Tests if input file exists
test -e $NODE
if [ "$?" = "0" ];
then

#Requests name for output file
 echo -n "Please enter a name for the output file."
 read OUTPUT

#Seperates input file based on A or B in mac address
 grep -e "-A-" $NODE > a.csv
 grep -e "-B-" $NODE > b.csv
 
#Tests if output file exists
 test -e $OUTPUT
 if [ "$?" = "0" ];
 then

#Checks if user would like to append or override the output file if it already exists
  echo -n "The output file already exists. Would you like to append or override it?[a/o]"
  read EXISTS

#Appends sorted to output file
  if [ "$EXISTS" = "a" ];
  then
   while read node
   do
    sed -n '1,2 p' b.csv >> $OUTPUT
    sed -n '1,2 p' a.csv >> $OUTPUT
    sed -i '1,2d' a.csv
    sed -i '1,2d' b.csv
   done < $NODE

#Overrides output file
  elif [ "$EXISTS" = "o" ];
  then
   rm $OUTPUT
   while read node
   do
    sed -n '1,2 p' b.csv >> $OUTPUT
    sed -n '1,2 p' a.csv >> $OUTPUT
    sed -i '1,2d' a.csv
    sed -i '1,2d' b.csv
   done < $NODE
  else

#User did not state if append or override
   echo "Invalid input. Please try restart."
   exit
  fi
 else

#Creates output file if does not exists
  while read node
  do
   sed -n '1,2 p' b.csv >> $OUTPUT
   sed -n '1,2 p' a.csv >> $OUTPUT
   sed -i '1,2d' a.csv
   sed -i '1,2d' b.csv
  done < $NODE
 fi
else

#File requested to be sorted does not exists
 echo "The file requested to be sorted does not exist."
 exit
fi

#Cleans up temp files
rm a.csv b.csv

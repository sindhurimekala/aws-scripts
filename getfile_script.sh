#!/usr/bin/bash
#set -x
echo "\n GET files Script Started.... \n"

read -p "Please enter Source Directory :"  SourceDir
echo $SourceDir

read -p "Please enter Target  Directory :" TargetDir
echo $TargetDir

cd $SourceDir

poll=60
nooftimes=10
i=1

while test $i -le $nooftimes
do
echo "Loop : " $i

file=`ls *.txt | grep $1 | sort -k 1 | head -1`
check_files=`ls *.txt | grep $1 | wc -l`

echo "number of files is " $check_files

if test $check_files -ne 0
then
        cp $file  ${TargetDir}/$file
        exit 0
else
        sleep $poll
    i=`expr $i + 1`
fi

done

if test $i -eq $nooftimes && $check_files eq 0
then
exit 1
fi


#! /bin/bash
echo "What directory do you want cleaned?"
read dir_name
cd "$dir_name"
ls 
echo "which of these files do you want removed?"
read file_name
echo "These files are being removed, is that ok with you? If so, enter 'yes'"
ls $file_name
read q_ans
if [ $q_ans == "yes" ]
then 
	echo "good bye"
	ls $file_name
	rm $file_name
fi
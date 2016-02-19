
#!/bin/sh

C="DEFGHIJKLMNOPQRSTUVWXYZABC"
uc=0 #user choice
while [ $uc -ne 99 ]; do
echo --------------------------------------------------
echo Enter 1 for Key cipher
echo Enter 2 for Rails
echo Enter 99 for exit
read uc
clear
if [ $uc -eq 1 ]; then
	echo enter 26 character key for encryption
	read C
	P="ABCDEFGHIJKLMNOPQRSTUVWXYZ"
	echo "=========="
	while IFS='' read -r line || [[ -n $line ]]; do

	OUT=`echo "$line" | tr "$P" "$C"`
	echo $OUT
	done < "$1"

elif [ $uc -eq 2 ]; then 
echo How many row you wan?
read row

while IFS='' read -r line || [[ -n $line ]]; do
##OUT=`echo "THIS IS A SIMPLE LAB" | tr $line $C`
##echo $OUT

INPUT=$line
SIZE=${#INPUT} #find size of the input
row1=$[$row-1] #just row -1 due to starting from 0
result=""
for r in `seq 0 $row1`;
do
	r1=$[$row-1]
	P=$[$r1*2] #p stand for primary gap
	S=$[$r*2] #s stand for second
	F=$[$P-S] #f stand for first
	if [ "$F" == "$P" ] || [ "$S" == "$P" ] ; then #if is the top and bttom row, no second gap
		x1=$r #x1 for finding possition of the char that need to be sub
		for x in `seq 0 $[($SIZE-1-$r)/$P]`; #take the start of the row and devide and see how many char in the row
		do
		        SUBSTRING=${INPUT:x1:1}
		        result="$result$SUBSTRING" #glue result together
			x1=$[$x1+$P] #find the next char ata
		done
	else
		x1=$r
		t=0 #to trigger between first and second gap
        	while (("$x1" < "$SIZE" )); do
			SUBSTRING=${INPUT:x1:1}
                        result="$result$SUBSTRING"
		if [ $((t%2)) -eq 0 ]; then
			x1=$[$x1+$F]
		else
			x1=$[$x1+$S]
		fi
		t=$[$t+1]
		done
	fi
	echo $result
done


done < "$1"

fi

done

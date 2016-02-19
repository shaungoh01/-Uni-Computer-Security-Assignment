
#!/bin/sh

C="DEFGHIJKLMNOPQRSTUVWXYZABC"
uc=0
while [ $uc -ne 99 ]; do
echo --------------------------------------------------
echo Enter 1 for Key cipher
echo Enter 2 for Rails
echo Enter 99 for exit
read uc
clear
if [ $uc -eq 1 ]; then
 echo hi
elif [ $uc -eq 2 ]; then 
echo How many row you wan?
read row

while IFS='' read -r line || [[ -n $line ]]; do

##OUT=`echo "THIS IS A SIMPLE LAB" | tr $line $C`
##echo $OUT

INPUT=$line
SIZE=${#INPUT}
row1=$[$row-1]
result=""
for r in `seq 0 $row1`;
do
	r1=$[$row-1]
	P=$[$r1*2]
	S=$[$r*2]
	F=$[$P-S]
	if [ "$F" == "$P" ] || [ "$S" == "$P" ] ; then
		x1=$r
		for x in `seq 0 $[($SIZE-1-$r)/$P]`;
		do
		        SUBSTRING=${INPUT:x1:1}
		        result="$result$SUBSTRING"
			x1=$[$x1+$P]
		done
	else
		x1=$r
		t=0
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

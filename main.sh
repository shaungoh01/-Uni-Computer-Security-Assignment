
#!/bin/sh

C="DEFGHIJKLMNOPQRSTUVWXYZABC"
row=4
while IFS='' read -r line || [[ -n $line ]]; do

OUT=`echo "THIS IS A SIMPLE LAB" | tr $line $C`
echo $OUT

INPUT=$line
SIZE=${#INPUT}
row1=$[$row-1]
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
		        echo $SUBSTRING:$x1
			x1=$[$x1+$P]
		done
		echo "--"
	fi
done


done < "$1"

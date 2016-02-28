#!/bin/sh

C="DEFGHIJKLMNOPQRSTUVWXYZABC"
uc=0 #user choice
ucs=0 #user choice to save
while [ $uc -ne 99 ]; do
echo --------------------------------------------------
echo Enter 1 for Key cipher encryption
echo Enter 2 for Rails
echo Enter 3 for Key cipher decryption
echo Enter 4 for Rails decryption
echo Enter 99 for exit
read uc
clear
if [ $uc -eq 1 -o $uc -eq 3 ]; then
	echo enter the key for encryption/decryption
	read C
	Temp=""
	Temp1=$C
	SizeC=${#C}
		for x in `seq 0 $SizeC`;
		do
			temp3=${Temp1:0:1}
			Temp1=${Temp1:1:${#Temp1}}
			Temp1="${Temp1//$temp3/}"
			Temp=$Temp$temp3
		done
	C=$Temp
	P="ABCDEFGHIJKLMNOPQRSTUVWXYZ"
	echo "=========="
	C=`echo "$C" | tr '[:lower:]' '[:upper:]'`
 	C="$C""${P//[$C]/}"
	P="$P"`echo "$P" | tr '[:upper:]' '[:lower:]'`
	C="$C"`echo "$C" | tr '[:upper:]' '[:lower:]'`
	echo c = $C
	echo "=========="
	echo Do you wan to save this?$'('Enter 1 for yes and any number for no$')'
        read ucs
	Tosave=""
	Filename="encrypted_data.txt"
	if [ $uc -eq 3 ]; then
		Temp=$P
		P=$C
		C=$Temp
		Filename="decrypted_data.txt"
	fi
	while IFS='' read -r line || [[ -n $line ]]; do

	OUT=`echo "$line" | tr "$P" "$C"`
	echo $OUT
	Tosave=$Tosave$'\n'$OUT
        done < "$1"
	if [ $ucs -eq 1 ]; then
		echo $Tosave > $Filename
	fi
elif [ $uc -eq 2 ]; then
echo How many row you wan?
read row
echo Do you wan to save this?$'('Enter 1 for yes and any number for no$')'
read ucs

resultS=""

while IFS='' read -r line || [[ -n $line ]]; do
##OUT=`echo "THIS IS A SIMPLE LAB" | tr $line $C`
##echo $OUT

INPUT="${line// /}"
SIZE=${#INPUT} #find size of the input
row1=$[$row-1] #just row -1 due to starting from 0
result=""
for r in `seq 0 $row1`;
do
	P=$[$row1*2] #p stand for primary gap
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

resultS=$resultS$result$'\r'

done < "$1"

if [ $ucs -eq 1 ]; then
        echo $resultS > "encrypted_data.txt"
fi

elif [ $uc -eq 4 ]; then
echo How many row you need to decrypt?
read row
echo Do you wan to save this?$'('Enter 1 for yes and any number for no$')'
read ucs

while IFS='' read -r line || [[ -n $line ]]; do
##OUT=`echo "THIS IS A SIMPLE LAB" | tr $line $C`
##echo $OUT

#echo line - $line
INPUT="${line// /}"
#echo input-$INPUT
SIZE=${#INPUT} #find size of the input
row1=$[$row-1] #just row -1 due to starting from 0
result=""
for r in `seq 0 $row1`;
do
        P=$[$row1*2] #p stand for primary gap
        S=$[$r*2] #s stand for second
        F=$[$P-S] #f stand for first
        if [ "$F" == "$P" ] || [ "$S" == "$P" ] ; then #if is the top and bttom row, no second gap
                x1=0 #x1 for finding possition of the char that need to be sub
                for x in `seq 0 $[($SIZE-1-$r)/$P]`; #take the start of the row and devide and see how many char in the row
                do
                        SUBSTRING=${INPUT:x:1}
                        NROW[$r]="${NROW[$r]}$SUBSTRING" #glue result together
			#echo nrow - ${NROW[$r]}
                done
		INPUT=${INPUT:x+1:${#INPUT}}
		#echo input - $INPUT
		#echo final nrow - ${NROW[$r]}
        else
                x1=$r
		xx=0
		t=0 #to trigger between first and second gap
                while (("$x1" < "$SIZE-1" )); do
			SUBSTRING=${INPUT:xx:1}
			#echo sub - $SUBSTRING
                        NROW[$r]="${NROW[$r]}$SUBSTRING"
			#echo nrow - ${NROW[$r]}
                if [ $((t%2)) -eq 0 ]; then
                        x1=$[$x1+$F]
                else
                        x1=$[$x1+$S]
                fi
		xx=$[$xx+1]
                t=$[$t+1]
		#echo x1 = $x1
                done
		INPUT=${INPUT:xx:${#INPUT}}
		#echo input - $INPUT
		#echo nrow - ${NROW[$r]}
        fi
done

needsub=${NROW[0]}
Result=${needsub:0:1}
NROW[0]=${needsub:1:${#needsub}}
T=0
for((i=1 ; i<$SIZE+1 ; i+=3));
do
	if [ $((T%2)) -eq 0 ]; then
        	for r in `seq 1 $row1`;
		do
		needsub=${NROW[$r]}
		Result=$Result${needsub:0:1}
		NROW[$r]=${needsub:1:${#needsub}}
		#echo $Result - $r
		done
        else
                for ((r=$row1-1 ; r>-1 ; r-=1 ));
		do
		needsub=${NROW[$r]}
		Result=$Result${needsub:0:1}
		NROW[$r]=${needsub:1:${#needsub}}
		#echo $Result - $r - d
		done
        fi
	T=$[$T+1]
done

if [ $ucs -eq 1 ]; then
	echo $Result > "decrypted_data.txt"
fi
echo $Result

done < "$1"


fi

done

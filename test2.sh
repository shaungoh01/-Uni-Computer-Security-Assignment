#!/bin/sh

INPUT="someletters_12345_moreleters.ext"

SIZE=${#INPUT}
for i in `seq 0 $SIZE`; 
do 
	SUBSTRING=${INPUT:i:1}
	echo $SUBSTRING
done

#!/bin/sh

C="DEFGHIJKLMNOPQRSTUVWXYZABC"
while IFS='' read -r line || [[ -n $line ]]; do

OUT=`echo "THIS IS A SIMPLE LAB" | tr $line $C`
echo $OUT

done < "$1"

#!/bin/sh

foo=7

if [ $((foo%2)) -eq 0 ];
then
    echo "even";
else
    echo "odd";
fi



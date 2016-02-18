#!/bin/sh

INPUT="someletters_12345_moreleters.ext"
SUBSTRING=${INPUT:12:5}
echo $SUBSTRING

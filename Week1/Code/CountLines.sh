#!/bin/bash
# Author: Jiqiu j.wu18@imperial.ac.uk
# Script: CountLines.sh
# Desc: count the lines of the file
# Arguments: the input file
# Date: Oct 2018

NumberLine=`wc -l < $1` 
#this command can be altertived by 
#NumberLine=`wc -l $1`
#count the lines of the input file and give the value to the variable Numberline
echo "The file $1 has $NumberLine lines"
#print the results on the screen
echo   
                 
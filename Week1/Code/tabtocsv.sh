#!/bin/bash
# Author: Jiqiu jw13818@ic.ac.uk
# Script: tabtocsv.sh
# Desc: substitude the tabs in the files with commas
# save the output into a .csv file
# Arguments: 1-> tab delimited file 
# Date: Oct 2018

echo "Creating a comma delimited version of $1 ..." 
#print the description on the screen
cat $1 | tr -s "\t" "," >> $1.csv 
#substitude the tabs in the files with commas and write into a new.csv file
#in bash, $1 can be the first input in the command, so easy compared with python and R!
echo "Done!"   
#print the process on the screen
exit           
#exit

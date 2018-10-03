#!/bin/bash
# Author: Jiqiu JW13818@imperial.ac.uk
# Script: tabtocsv.sh
# Desc: substitude the tabs in the files with commas
# save the output into a .csv file
# Arguments: 1-> tab delimited file 
# Date: Oct 2018

echo "Creating a comma delimited version of $1 ..."
cat $1 | tr -s "\t" "," >> $1.csv
echo "Done!"
exit

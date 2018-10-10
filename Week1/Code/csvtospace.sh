#!/bin/bash
# Author: Jiqiu JW13818@ic.ac.uk
# Script: csvtospace.sh
# Desc: substitude the commas in the files with spaces
# save the output into a .txt file
# Arguments: 1-> commas delimited file 
# Date: Oct 2018

echo "Creating a spaces delimited version of $1 ..."
cat $1 | tr -s "," " " >>$1.txt
echo "Done!"
exit

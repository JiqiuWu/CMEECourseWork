#!/bin/bash
# Author: Jiqiu  jw13818@ic.ac.uk
# Script: csvtospace.sh
# Desc: substitude the commas in the files with spaces
# save the output into a .txt file
# Arguments: 1-> commas delimited file 
# Date: Oct 2018

echo "Creating a spaces delimited version of $1 ..." # print the aim of the script
cat $1 | tr -s "," " " >>$1.txt       #print the content of input file and replace commas with spaces
echo "Done!"                          #print the process on the screen
exit                                  #exit

#!/bin/bash
# Author: Jiqiu j.wu18@imperial.ac.uk
# Script: ConcatenateTwoFiles.sh
# Desc: Concatenate two files into one file
# Arguments: file1 and file2
# Date: Oct 2018

cat $1 > $3    #print the content in file1 to file3
cat $2 >> $3   #print the content in file2 to file3
echo "Merged File is"
cat $3         #print the file3 with the content from file1 and file2
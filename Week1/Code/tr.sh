#!/bin/bash
# Author: Jiqiu j.wu18@imperial.ac.uk
# Script: tr.sh
# Desc: simple exercise for tr commands
# Arguments: none
# Date: Jan 2019


echo "Remove    excess      spaces." | tr -s "\b" " " 
#replace each sequence of a repeated character that is listed  in the last 
#specified SET, with a single occurrence of that character

echo "remove all the as" | tr -d "a"
#delete 

echo "set to uppercase" | tr [:lower:] [:upper:]
#change to upper

echo "10.00 only numbers 1.33" | tr -d [:alpha:] | tr -s " " ","
#remove all letters and chane backspace to ,



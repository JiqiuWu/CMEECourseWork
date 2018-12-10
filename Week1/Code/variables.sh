#!/bin/bash
# Author: Jiqiu j.wu18@imperial.ac.uk
# Script: variables.sh
# Desc: show us how to use variables by $
# Arguments: none
# Date: Oct 2018

# Shows the use of variables
MyVar='some string' #write the value into the variable MyVar
echo 'the current value of the variable is' $MyVar
echo 'Please enter a new string'
read MyVar
echo 'the current value of variable is' $MyVar
## Reading multiple values
echo 'enter two numbers separated by space(s)'
read a b
echo 'you entered' $a 'and' $b '. Their sum is'
mysum=`expr $a + $b`

#!/bin/bash
# Author: Jiqiu j.wu18@imperial.ac.uk
# Script: MyExampleScript.sh
# Desc: say hello to the user
# Arguments: none
# Date: Oct 2018, modified in Jan 2019

msg1="Hello"  #write hello to the variant msg1
msg2=$USER    #get the user name to the variant msg2
echo "$msg1 $msg2" #say hello to the usr on the screen
echo "Hello $USER" 
#$USER is the environmental variable and it means jiqiu contained in .bashrc
echo #print a null line on the screen
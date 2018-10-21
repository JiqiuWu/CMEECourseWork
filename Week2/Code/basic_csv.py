#!/usr/bin/env python3

"""a script that can improve the understanding of input and output in Python"""

__author__ = 'Jiqiu Wu (j.wu18@imperial.ac.uk)'
__version__ = '0.0.1'

import csv  #import csv module which can handle csv files

# Read a file containing:
# 'Species','Infraorder','Family','Distribution','Body mass male (Kg)'
f = open('../Data/testcsv.csv','r') #open the testcsv file for reading

csvread = csv.reader(f) #assign the content of csv file to variable csvread
temp = [] #set a null variable waiting for adding value
for row in csvread:
    temp.append(tuple(row))
    print(row)
    print("The species is", row[0]) #row can be changed to any other words

f.close

# Write a file containing only species name and Body mass
f = open('../Data/testcsv.csv','r') #open the testcsv file for reading
g = open('../Data/bodymass.csv','w') #open the testcsv file for writing

csvread = csv.reader(f)
csvwrite = csv.writer(g)
for row in csvread:
	print(row)
	csvwrite.writerow([row[0], row[4]]) #row can be changed to any other words

f.close()  #close the file testcsv.csv
g.close()  #close the file bodymass.csv

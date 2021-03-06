#!/usr/bin/env python3

"""Some functions exemplifying the use of pdb"""
#docstrings are considered part of the running code (normal comments are
#stripped). Hence, you can access your docstrings at run time.
__author__ = 'Jiqiu Wu (j.wu18@imperial.ac.uk)'
__version__ = '0.0.1'


import csv
import sys
import pdb
import re

#Define function
def is_an_oak(name):
    """ Returns True if name is starts with 'quercus' 

    >>> is_an_oak('Fagus sylvatica')
    False
    >>> is_an_oak('Quercus robur')
    True
    >>> is_an_oak('Quercuss cerris')
    False
    """
    # use Regular expression to match "quercus"
    if re.match('^quercus\s', name, flags=re.I) != None:
        return True
    else:
        return False



def main(argv): 
    f = open('../Data/TestOaksData.csv','r')
    g = open('../Result/JustOaksData.csv','w') #Result is better than data
    taxa = csv.reader(f)
    header = next(taxa) #ignore the header for extra 1
    csvwrite = csv.writer(g)
    csvwrite.writerow(header) # wirte the header to the JustOaksData file for extra 2
    oaks = set()
    for row in taxa:
        print(row)
        print ("The genus is: ") 
        print(row[0] + '\n')
        if is_an_oak(row[0] + ' '):
            print('FOUND AN OAK!\n')
            csvwrite.writerow([row[0], row[1]])    

    return 0
    
if (__name__ == "__main__"):
    status = main(sys.argv)
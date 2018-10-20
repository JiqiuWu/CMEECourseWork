#!/usr/bin/env python3

"""some exercise to improve the understanding of for and while loops"""

__author__ = 'Jiqiu Wu (j.wu18@imperial.ac.uk)'
__version__ = '0.0.1'

#1)
for i in range(3, 17):
    print ('hello') #14 hellos

#2)
for j in range(12):
    if j % 3 == 0:
        print ('hello') #4 hellos

#3)
for j in range(15):
    if j % 5 == 3:
        print ('hello') #3 hellos
    elif j % 4 == 3:
        print ('hello') #3 hellos

#4)
z = 0
while z != 15:
    print ('hello')
    z = z + 3 #5 hellos

#5)
z = 12
while z < 100:
    if z == 31:
        for k in range(7):
            print ('hello') #7 hellos
    elif z == 18:
        print ('hello') #1 hellos
    z = z + 1
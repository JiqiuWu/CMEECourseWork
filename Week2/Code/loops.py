#!/usr/bin/env python3

"""some exercises to improve the understanding of for loops"""

__author__ = 'Jiqiu Wu (j.wu18@imperial.ac.uk)'
__version__ = '0.0.1'

# for loops in Python
for i in range(5):
    print (i) # the result are 0, 1, 2, 3, 4

my_list = [0, 2, "geronimo", 3.0, True, False]
for k in my_list:
    print (k) # the result are 0, 2, geronimo, 3.0, True, False

total = 0
summands = [0, 1, 11, 111, 1111]
for s in summands:
    total = total + s
    print (total) # the result are 0, 1, 12, 123, 1234

# while loops in Python
z = 0
while z < 100:
    z = z +1
    print (z) # the result are 1,2,....,98,99,100

b = True
while b:
    print ("GERONIMO! infinite loop! ctrl+c to stop!")
# ctrl + c to stop!

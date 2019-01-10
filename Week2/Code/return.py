#!/usr/bin/env python3

"""exercise for return"""

__author__ = 'Jiqiu Wu (j.wu18@imperial.ac.uk)'
__version__ = '0.0.1'

x = 1
y = 2
def add(x, y):
	z = x + y	
print(add(x,y))
#The result is None.

x = 1
y = 2
def add(x, y):
	z = x + y
	return z
print(add(x,y))
#The result is 3.

# x = 1
# y = 2
# def add(x, y):
# 	z = x + y
# print(z)
#The result is 100.

# x = 2
# y = 2
# def add(x, y):
# 	z = x + y
# print(z)
#The result is 100 as well.

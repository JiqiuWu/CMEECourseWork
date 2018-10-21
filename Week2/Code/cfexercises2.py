#!/usr/bin/env python3

"""some examples to improve the understanding of if and while loops"""

__author__ = 'Jiqiu Wu (j.wu18@imperial.ac.uk)'
__version__ = '0.0.1'

# What does each of fooXX do? 

import sys #import sys so that the test section can be conducted

def foo1(x = 4):
    return x ** 0.5  # obtain the square root of x

def foo2(x = 4, y = 7):
    if x > y:     
        return x
    return y # obtain the larger one

def foo3(x = 1, y = 2, z = 3):  
    if x > y:
        tmp = y
        y = x
        x = tmp
    if y > z:
        tmp = z
        z = y
        y = tmp
    return [x, y, z] #order from small one to big one, but i think there is a problem???let me think about

def foo4(x = 3):
    result = 1
    for i in range(1, x + 1):
        result = result * i
    return result # obtain the factorial of x

def foo5(x = 5): 
    if x == 1:
        return 1
    return x * foo5(x - 1) # a recursive function that calculates the factorial of x
     
def foo6(x=5): # Calculate the factorial of x in a different way
    facto = 1
    while x >= 1:
        facto = facto * x
        x = x - 1
    return facto

def main(argv):
    print(foo1(4))
    print(foo2(4,7))
    print(foo3(1, 2, 3))
    print(foo4(3))
    print(foo5(5))
    print(foo6(5))
    return 0


if (__name__ == "__main__"):
    status = main(sys.argv)
sys.exit(status)
#!/usr/bin/env python3

"""some examples to improve the understanding of if and while loops"""

__author__ = 'Jiqiu Wu (j.wu18@imperial.ac.uk)'
__version__ = '0.0.1'

# What does each of fooXX do? 

import sys #import sys so that the test section can be conducted

def foo_1(x = 4):
    """define a function that will calculate the square root"""
    return x ** 0.5  # obtain the square root of x

def foo_2(x = 4, y = 7):
    """define a function that will return the bigger number"""
    if x > y:     
        return x
    return y # obtain the larger one

def foo_3(x = 1, y = 2, z = 3):  
    """define a function that will order the three numbers from small one to big one"""
    if x > y:
        tmp = y
        y = x
        x = tmp
    if y > z:
        tmp = z
        z = y
        y = tmp
    return [x, y, z] #order from small one to big one, but i think there is a problem???let me think about

def foo_4(x = 3):
    """define a function that will obtain the factorial of x"""
    result = 1
    for i in range(1, x + 1):
        result = result * i
    return result # obtain the factorial of x

def foo_5(x = 5): 
    """define a function that will calculate the factorial of x"""
    if x == 1:
        return 1
    return x * foo_5(x - 1) # a recursive function that calculates the factorial of x
     
def foo_6(x=5): # Calculate the factorial of x in a different way
    """define a function that will calculate the factorial of x in a different way"""    
    facto = 1
    while x >= 1:
        facto = facto * x
        x = x - 1
    return facto

def main(argv):
    print(foo_1(4))
    print(foo_2(4,7))
    print(foo_3(1, 2, 3))
    print(foo_4(3))
    print(foo_5(5))
    print(foo_6(5))
    return 0


if (__name__ == "__main__"):
    status = main(sys.argv)
    sys.exit(status)
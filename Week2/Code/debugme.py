#!/usr/bin/new/env python3 #shebang

"""debug trap""" #docstring


__author__ = 'Jiqiu Wu (j.wu18@imperial.ac.uk)'
__version__ = '0.0.1'

def createabug(x=4):
    y = x**4
    z = 0.1
    y = y/z
    return y
createabug(25)

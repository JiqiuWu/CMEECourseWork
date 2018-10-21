#!/usr/bin/env python3

"""an example to improve the understanding of sys module"""

__author__ = 'Jiqiu Wu (j.wu18@imperial.ac.uk)'
__version__ = '0.0.1'

import sys
print("This is the name of the script: ", sys.argv[0])
print("Number of arguments: ",len(sys.argv))
print("The arguments are: ",str(sys.argv))

#!/usr/bin/new/env python3 #shebang

"""start with proper python functions""" #docstring


__author__ = 'Jiqiu Wu (j.wu18@imperial.ac.uk)'
__version__ = '0.0.1'


## imports ##
import sys # module to interface our program with the operating system
##very useful!!

## constants ##

## functions ##
def main(argv):
    """ Main entry point of the program. Define the main function."""
    print('This is a boilerplate') # NOTE: indented using two tabs or 4 spaces
    return 0

if __name__ == "__main__":
    """Makes sure the "main" function is called from command line"""
    status = main(sys.argv)
    sys.exit(status)


   	  	  

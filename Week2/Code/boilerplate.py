#!/usr/bin/new/env python3 #shebang

"""Description of this program of application.
      You can use several lines""" #docstring

__appname__ = '[application name here]'
__author__ = 'Jiqiu Wu (j.wu18@imperial.ac.uk)'
__version__ = '0.0.1'
__license__ = "License for this code/program" #internal variables

## imports ##
import sys # module to interface our program with the operating system

## constants ##

## functions ##
def main(argv):
    """ Main entry point of the program"""
    print('This is a boilerplate') # NOTE: indented using two tabs or 4 spaces
    return 0

if __name__ == "__main__":
    """Makes sure the "main" function is called from command line"""
    status = main(sys.argv)
    sys.exit("I am exiting right now!")

      	  	  

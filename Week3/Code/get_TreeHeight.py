#!/usr/bin/env python3

"""calculate the height of trees using Python"""

__author__ = 'Jiqiu Wu (j.wu18@imperial.ac.uk)'
__version__ = '0.0.1'
# This function calculates heights of trees given distances of each
# from its base and angle to its top, using the trigonometric for
#
# height = distance * tan(radians)
#
# AGRUMENTS
# degrees: The angle of elevation of tree
# distance: The distance from base of tree(e.g. meters)
#
# OUTPUT
# The heights of the tree, same units as "distance"

import sys
import os
import numpy

with open('sys.argv[1]') as file_object:
    MyTree = file_object.read()

def TreeHeight(degrees,distance):
"""define a function that can calculate the height of trees using Python"""
    radians = degrees * pi / 180
    height = distance * tan(radians)

    return height

TreeHeight.m = TreeHeight(MyTree[,3], MyTree[,2])
MyTree[TreeHeight.m] = TreeHeight.m

filename, flle_extension = os.path.splitext(args[1])#grab the filename for input filename to output filename

output_filename = "../results/" + filename + "_treeheight.csv"


with open(output_filename,'w') as file_object:
    file_object.write(MyTree)

#it can't finish the aim, something wrong here. It need further modification.
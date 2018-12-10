#!/usr/bin/env python3

"""change the R script into Python from Vectorize1.R"""

__author__ = 'Jiqiu Wu (j.wu18@imperial.ac.uk)'
__version__ = '0.0.1'


import numpy 
import time


def SumbyLoop(M):
    """sum matrix elements by loop"""
    Tot = 0
    for i in range(M.shape[0]):
        for j in range(M.shape[1]):
            Tot += M[i][j]
    return Tot


def SumbyVec(M):
    """sum matrix elements by vectorization"""
    Tot = numpy.sum(M)
    return Tot


# initialize matrix M
numpy.random.seed(27)
M = numpy.random.rand(1000, 1000)

# time consuming comparison
# Loop verion
tic = time.time()
loop = SumbyLoop(M)
toc = time.time()

print("Looping sum is:", loop)
print("Loop takes: " + str(1000*(toc - tic)) + " ms")

# vectorized version
tic = time.time()
vec = SumbyVec(M)
toc = time.time()

print("Vectorized sum is:", vec)
print("Vectorized takes: " + str(1000*(toc - tic)) + " ms")
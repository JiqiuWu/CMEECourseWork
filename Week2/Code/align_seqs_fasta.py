#!/usr/bin/env python3

"""align seqs script and sequences from two fasta files"""

__author__ = 'Jiqiu Wu (j.wu18@imperial.ac.uk)'
__version__ = '0.0.1'

import sys

lines1 = ""
lines2 = "" #generate two empty sequences


if len(sys.argv) == 1:
    f1 = open("../Data/407228326.fasta")
    f2 = open("../Data/407228412.fasta")
else:
    f1 = open(sys.argv[1],"r")
    f2 = open(sys.argv[2],"r")

# to meet that it should still run if no inputs 
#were given, using two fasta sequences from the data directory as defaults


next(f1) #ignore the first line
for line in f1:
    lines1 += line
f1.close()

next(f2) #ignore the first line
for line in f2:
    lines2 += line
f2.close()

seq1 = lines1.replace('\n', '')
seq2 = lines2.replace('\n', '')


l1 = len(seq1)
l2 = len(seq2)
if l1 >= l2:
    s1 = seq1
    s2 = seq2
else:
    s1 = seq2
    s2 = seq1
    l1, l2 = l2, l1 # swap the two lengths

# A function that computes a score by returning the number of matches starting
# from arbitrary startpoint (chosen by user)
def calculate_score(s1, s2, l1, l2, startpoint):
    matched = "" # to hold string displaying alignements
    score = 0
    for i in range(l2):
        if (i + startpoint) < l1:
            if s1[i + startpoint] == s2[i]: # if the bases match
                matched = matched + "*"
                score = score + 1
            else:
                matched = matched + "-"

    # some formatted output
    print("." * startpoint + matched)           
    print("." * startpoint + s2)
    print(s1)
    print(score) 
    print(" ")

    return score

# Test the function with some example starting points:
# calculate_score(s1, s2, l1, l2, 0)
# calculate_score(s1, s2, l1, l2, 1)
# calculate_score(s1, s2, l1, l2, 5)

# now try to find the best match (highest score) for the two sequences
my_best_align = None
my_best_score = -1

for i in range(l1): # Note that you just take the last alignment with the highest score
    z = calculate_score(s1, s2, l1, l2, i)
    if z > my_best_score:
        my_best_align = "." * i + s2 # think about what this is doing!
        my_best_score = z 

print(my_best_align)
print(s1)
print("Best score:", my_best_score)
#!/usr/bin/env python3

"""align seqs script and sequences are from a csv file and save all the best results"""

__author__ = 'Jiqiu Wu (j.wu18@imperial.ac.uk)'
__version__ = '0.0.1'


import csv
import pickle

line = []
f = open("../Data/align_seqs.csv","r")
for lines in f:
    line.append(lines.strip('\n'))
f.close() #open the csv file and read

seq1 = line[0]
seq2 = line[1] #assign one sequence to seq1, the other to seq2

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
    if z >= my_best_score:
        my_best_align = "." * i + s2 # think about what this is doing!
        my_best_score = z 

aligned_seqs = pickle.load("../Result/aligned_seqs.txt")
aligned_seqs.pickle.dump(my_best_align + "\n" + s1 + "\n"+"Best_score: "+str(my_best_score))
aligned_seqs.close()
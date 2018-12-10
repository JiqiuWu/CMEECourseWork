#!/usr/bin/env python3

"""a script that can improve the understanding of Input/Output in Python"""

__author__ = 'Jiqiu Wu (j.wu18@imperial.ac.uk)'
__version__ = '0.0.1'
############
# FILE INPUT
############

import pickle #import the pickle module, a storage and load? module, maybe save storage space and speed up


# Open a file for reading
f = open('../Sandbox/test.txt', 'r') #open the txt file for reading
# use "implicit" for loop
# if the object is a file, python will cycle over lines
for line in f: # an implicit loop, go through every line of test.txt
	print(line) # print every line of text file

# close the file
f.close

# Same example, skip blank lines
f = open('../Sandbox/test.txt','r') #open the txt file for reading
for line in f:
	if len(line.strip()) > 0: #check if the line is empty
	    print (line) # print every line of text file

f.close() #close the file

############
# FILE OUTPUT
############
# Save the elements of a list to a file
list_to_save = range(100) #from 0 to 99, python index starts from 0
f = open('../Sandbox/testout.txt','w') #open the txt file for writing
for i in list_to_save:
    f.write(str(i) + '\n') ## convert into integer, write into the file and add a new line at the end

f.close() # close f file

###########
# STORING OBJECTS
###########
# To save an object (even complex) for later use
my_dictionary = {"a key": 10, "another key":11}


f = open('../Sandbox/tessp.p','wb')## note the b: accept binaryfiles
pickle.dump(my_dictionary, f) # save the content of my_dictionary to tessp.p, which can't be read by human and open by editor
f.close()

## Load the data again
f = open('../Sandbox/tessp.p','rb')
another_dictionary = pickle.load(f) #write the the content of my_dictionary in tessp.p into another_dictionary
f.close

print(another_dictionary)


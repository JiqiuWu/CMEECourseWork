#!/usr/bin/env python3

"""Some exercises to understand list comprehension and dictionary"""

__author__ = 'Jiqiu Wu (j.wu18@imperial.ac.uk)'
__version__ = '0.0.1'

taxa = [ ('Myotis lucifugus','Chiroptera'),
         ('Gerbillus henleyi','Rodentia',),
         ('Peromyscus crinitus', 'Rodentia'),
         ('Mus domesticus', 'Rodentia'),
         ('Cleithrionomys rutilus', 'Rodentia'),
         ('Microgale dobsoni', 'Afrosoricida'),
         ('Microgale talazaci', 'Afrosoricida'),
         ('Lyacon pictus', 'Carnivora'),
         ('Arctocephalus gazella', 'Carnivora'),
         ('Canis lupus', 'Carnivora'),
        ]

# Write a short python script to populate a dictionary called taxa_dic 
# derived from  taxa so that it maps order names to sets of taxa. 
# E.g. 'Chiroptera' : set(['Myotis lucifugus']) etc. 

taxa_dic = {} #set an empty dictionary to hold key and value
taxa_order = list(set([bird[1] for bird in taxa])) #generate a list with no redundant order

for order in taxa_order:
    for bird in taxa:
        if bird[1] == order:
            taxa_dic.setdefault(order,set()).add(bird[0]) #return he key value available in the dictionary
## need further comprehension
print(taxa_dic)

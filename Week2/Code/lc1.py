#!/usr/bin/env python3

"""Some exercises to understand list comprehension"""

__author__ = 'Jiqiu Wu (j.wu18@imperial.ac.uk)'
__version__ = '0.0.1'

birds = ( ('Passerculus sandwichensis','Savannah sparrow',18.7),
          ('Delichon urbica','House martin',19),
          ('Junco phaeonotus','Yellow-eyed junco',19.5),
          ('Junco hyemalis','Dark-eyed junco',19.6),
          ('Tachycineata bicolor','Tree swallow',20.2),
         )

#(1) Write three separate list comprehensions that create three different
# lists containing the latin names, common names and mean body masses for
# each species in birds, respectively. 

latin_names = [raw[0] for raw in birds ]
common_names = [raw[1] for raw in birds]
mean_body_masses = [raw[2] for raw in birds]
#use the list comprehension to add values
print(latin_names)
print(common_names)
print(mean_body_masses)


# (2) Now do the same using conventional loops (you can choose to do this 
# before 1 !). 
latin_names = []
common_names = []
mean_body_masses = []    # creat empty lists waiting for adding

for bird in birds:
    latin_names.append(bird[0])
    common_names.append(bird[1])
    mean_body_masses.append(bird[2])    #add respective value to the list
print (latin_names, '\n', common_names, '\n', mean_body_masses)

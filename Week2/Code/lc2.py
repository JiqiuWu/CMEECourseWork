#!/usr/bin/env python3

"""Some more exercises to understand list comprehension"""

__author__ = 'Jiqiu Wu (j.wu18@imperial.ac.uk)'
__version__ = '0.0.1'

# Average UK Rainfall (mm) for 1910 by month
# http://www.metoffice.gov.uk/climate/uk/datasets
rainfall = (('JAN',111.4),
            ('FEB',126.1),
            ('MAR', 49.9),
            ('APR', 95.3),
            ('MAY', 71.8),
            ('JUN', 70.2),
            ('JUL', 97.1),
            ('AUG',140.2),
            ('SEP', 27.0),
            ('OCT', 89.4),
            ('NOV',128.4),
            ('DEC',142.2),
           )

# (1) Use a list comprehension to create a list of month,rainfall tuples where
# the amount of rain was greater than 100 mm.
 
greater_100mm = [greater_100mm for greater_100mm in rainfall if greater_100mm[1] > 100]

print(greater_100mm)

# (2) Use a list comprehension to create a list of just month names where the
# amount of rain was less than 50 mm. 

less_50mm = [less_50mm for less_50mm in rainfall if less_50mm[1] <50]

print(less_50mm)

# (3) Now do (1) and (2) using conventional loops (you can choose to do 
# this before 1 and 2 !). 

greater_100mm = []
for rainfalls in rainfall:
    if rainfalls[1] > 100:
        greater_100mm.append(rainfalls)
        print(greater_100mm)

less_50mm = []
for rainfalls in rainfall:
    if rainfalls[1] <50:
        less_50mm.append(rainfalls)
        print(less_50mm)

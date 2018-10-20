#!/usr/bin/env python3

"""some examples to understand list comprehension"""

__author__ = 'Jiqiu Wu (j.wu18@imperial.ac.uk)'
__version__ = '0.0.1'

birds = ( ('Passerculus sandwichensis','Savannah sparrow',18.7),
          ('Delichon urbica','House martin',19),
          ('Junco phaeonotus','Yellow-eyed junco',19.5),
          ('Junco hyemalis','Dark-eyed junco',19.6),
          ('Tachycineata bicolor','Tree swallow',20.2),
        )

# Birds is a tuple of tuples of length three: latin name, common name, mass.
# write a (short) script to print these on a separate line or output block by species 
# Hints: use the "print" command! You can use list comprehensions!

latin_names = [latin_names[0] for latin_names in birds]
common_names = [common_names[1] for common_names in birds]
mean_body_masses = [mean_body_masses[2] for mean_body_masses in birds]

print(latin_names)
print(common_names)
print(mean_body_masses)
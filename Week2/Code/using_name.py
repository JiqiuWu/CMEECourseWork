#!/usr/bin/env python3

"""an example to improve the understanding of __name__ =='__main__' """

__author__ = 'Jiqiu Wu (j.wu18@imperial.ac.uk)'
__version__ = '0.0.1'

if __name__ == '__main__': #so that the script can run itself and be imported
    print ('This program is being run by itself')
else:
	print ('I am being imported form another module')
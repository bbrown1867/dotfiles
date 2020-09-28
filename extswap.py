#! /usr/bin/python

import os
import sys

if len(sys.argv) != 3:
    print('Change the extensions of all files in current directory. Usage:')
    print('\textswap.py <old> <new>')
else:
    old = sys.argv[1]
    new = sys.argv[2]
    for fold in os.listdir('.'):
        if fold.endswith(old):
            fnew = fold.replace(old, new)
            os.rename(fold, fnew)

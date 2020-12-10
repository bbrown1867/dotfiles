#! /usr/bin/python

import os
import sys


def bname_diff(path1, path2):
    for p1, p2 in [(path1, path2), (path2, path1)]:
        for f1 in os.listdir(p1):
            for f2 in os.listdir(p2):
                f1 = os.path.splitext(f1)[0]
                f2 = os.path.splitext(f2)[0]
                if f1 == f2:
                    break
            else:
                print('Only in %s: %s' % (p1, f1))


if __name__ == '__main__':
    if len(sys.argv) != 3:
        print('Diffs two directories using file basenames only. Usage:')
        print('\tbname_diff.py <dir1> <dir2>')
    else:
        path1 = sys.argv[1]
        path2 = sys.argv[2]
        assert os.path.exists(path1) and os.path.exists(path2)
        bname_diff(path1, path2)

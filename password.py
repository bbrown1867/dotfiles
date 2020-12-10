#! /usr/bin/python

"""
Generates a 16 character password by concatenating a secret with a phrase,
and hashing it with md5. Switch the first letter to capital or switch the last
character to a special, if necessary to satisfy password requirements.
"""

import hashlib
import getpass
import argparse


def insert_capital(st):
    for i in range(len(st)):
        if st[i].isalpha():
            break
    st2 = ''
    for j in range(len(st)):
        if j == i:
            st2 += st[j].upper()
        else:
            st2 += st[j]
    return st2


def insert_special(st):
    st2 = ''
    st2 += st[:15]
    st2 += '!'
    return st2


def generate_password(secret, phrase, capital=False, special=False):
    m = hashlib.md5()
    m.update(secret.encode('utf-8'))
    m.update(phrase.encode('utf-8'))
    st = str(m.hexdigest()[:16])
    if capital:
        st = insert_capital(st)
    if special:
        st = insert_special(st)
    print(st)


if __name__ == '__main__':
    parser = argparse.ArgumentParser(__doc__)
    parser.add_argument('phrase')
    parser.add_argument('-u', dest='capital', action='store_true')
    parser.add_argument('-s', dest='special', action='store_true')
    args = parser.parse_args()
    secret = getpass.getpass()
    generate_password(secret, args.phrase, args.capital, args.special)

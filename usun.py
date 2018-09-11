#!/usr/bin/env python

for line in open('test.txt', 'r'):
    seen = []
    words = line.rstrip('\n').split()

    for word in words:
        if not word in seen:
            print word,
            seen.append(word)
    print

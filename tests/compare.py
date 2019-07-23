#!/usr/bin/env python3

# utility to compare the clone and convergence files based on
# equivalence and not bit equality

import sys

def parse_clone(filename):
    def parse_line(line):
        fields = line.strip().split('\t')
        if len(fields) != 3:
            raise ValueError(line)
        # sort the pair and pass thru singleton/global
        return (sorted(fields[:2]), fields[2])

    with open(filename) as fh:
        return sorted(map(parse_line, fh))

def check_clone(a, b):
    return parse_clone(a) == parse_clone(b)

def parse_convergence(filename):
    def parse_line(line):
        fields = line.strip().split('\t')
        if len(fields) != 3:
            raise ValueError(line)

        return (fields[0], sorted(fields[2].split(' ')))

    with open(filename) as fh:
        return sorted(map(parse_line, fh))

def check_convergence(a, b):
    return parse_convergence(a) == parse_convergence(b)

args_help = '<clone|convergence> <file-a> <file-b>'
args = sys.argv[1:]

if len(args) == 3 + 1:
    raise ValueError(args_help)

kind, a, b = sys.argv[1:]

if kind == 'clone':
    result = check_clone(a, b)
elif kind == 'convergence':
    result = check_convergence(a, b)

else:
    raise ValueError(args_help)

print(a)
print(b)
print('PASS' if result else 'FAIL')

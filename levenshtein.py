#!/usr/bin/env python


def distance(a, b):
    """
    A super naive implementation of the Levenshtein distance formula.

    :param a: first test string
    :param b: second test string
    :returns: the Levenshtein distance between the two strings
    """
    if a == b:
        return 0
    if len(a) == 0 or len(b) == 0:
        # Just get the length of the non-zero string. Max or sum will work
        # equally well.
        return max([len(a), len(b)])
    # Using zip returns a list of tuples, and it's a list of length equal to
    # the shortest component list, so we don't need to worry about explicitly
    # identifying the shortest string.
    return sum([0 if char[0] == char[1] else 1 for char in zip(a, b)]) + abs(len(a) - len(b))

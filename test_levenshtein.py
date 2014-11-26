#!/usr/bin/env python3

import unittest
from levenshtein import distance


class DistanceTests(unittest.TestCase):

    def test_empty(self):
        self.assertEqual(0, distance("", ""))

    def test_unbalanced(self):
        self.assertEqual(6, distance("", "python"))
        self.assertEqual(4, distance("", "ruby"))

    def test_equal(self):
        self.assertEqual(0, distance("zippy", "zippy"))

    def test_distance(self):
        self.assertEqual(1, distance("zipp", "zippy"))
        self.assertEqual(1, distance("ippy", "zippy"))  # oops...
        self.assertEqual(2, distance("sipry", "zippy"))


if __name__ == '__main__':
    unittest.main()

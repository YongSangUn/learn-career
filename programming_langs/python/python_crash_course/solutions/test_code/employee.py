# -*- coding: utf-8 -*-
import unittest


class Employee():

    def __init__(self, first, last):
        self.first = first
        self.last = last
        self.salary = 0
        self._increment = 5000

    def giveRaise(self, increment=None):
        if increment is None:
            increment = self._increment
        self.salary = self.salary + increment


class TestEmplotee(unittest.TestCase):

    def setUp(self):
        self.increment = 1000
        self.employee = Employee('SangUn', 'Yong')
        self.defaultIncrement = self.employee._increment

    def testGiveDefaultRaise(self):
        self.employee.giveRaise()
        self.assertEqual(self.employee.salary, self.defaultIncrement)

    def testGiveCustomRaise(self):
        self.employee.giveRaise(self.increment)
        self.assertEqual(self.employee.salary, self.increment)


unittest.main()

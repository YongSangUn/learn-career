# chapter 11

## 11-1..2

```python
# 11-1
$ cat city_functions.py
# -*- coding: utf-8 -*-

def cityCountry(city, country, population=None):
    if population:
        message = f'{city}, {country} - population {population}'
    else:
        message = f'{city}, {country}'
    return message.title()

# -------------------------------

# 11-2
$ cat test_cities.py
# -*- coding: utf-8 -*-

import unittest
from city_functions import cityCountry

class CityTestCase(unittest.TestCase):

    def testCityCountry(self):
        message = cityCountry("shanghai", 'china')
        self.assertEqual(message, 'Shanghai, China')

    def testCityCountryPopulation(self):
        message = cityCountry("shanghai", 'china', population=26000000)
        self.assertEqual(message, 'Shanghai, China - Population 26000000')

unittest.main()

# 11-3
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
```

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
```

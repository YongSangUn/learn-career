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
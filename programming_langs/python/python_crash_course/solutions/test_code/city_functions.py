# -*- coding: utf-8 -*-


def cityCountry(city, country, population=None):
    if population:
        message = f'{city}, {country} - population {population}'
    else:
        message = f'{city}, {country}'
    return message.title()


message = cityCountry('shanghai', 'China')
print(message)

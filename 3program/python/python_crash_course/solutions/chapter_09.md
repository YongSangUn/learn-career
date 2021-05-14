# chapter 09

## 9-1

```python
# -*- coding: utf-8 -*-

# 9-1
class Restaurant():

    def __init__(self, restaurantName,cuisineType):
        self.restaurantName = restaurantName
        self.cuisineType = cuisineType
        self.number_served = 0

    def describeRestaurant(self):
        print(f'{self.restaurantName}, {self.cuisineType}')

    def openRestaurant(self):
        print(f'{self.restaurantName} opening.')

    def setNumberServed(self,numbers):
        print(f'{numbers} people eat.')

    def incrementNumber(self,numbers):
        if not isinstance(int, numbers):
            print('Enter the inter') and numbers
        if numbers <=0:



# 9-3
class User():

    def __init__(self, firstName, lastName):
        self.firstName = firstName
        self.lastName = lastName
        self.fullName = f'{firstName} {lastName}'

    def describeUser(self):
        print(f'First name: {self.firstName}')
        print(f'Last name: {self.lastName}')

    def greetUser(self):
        print(f'Hello {self.fullName}')

michael = User('Michael', 'Jackson')
michael.birth = 'August 29, 1958'
michael.describeUser()
michael.greetUser()
```

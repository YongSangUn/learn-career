# chapter 09

## 9-1..5

```python
# -*- coding: utf-8 -*-

# 9-1
class Restaurant():

    def __init__(self, restaurantName,cuisineType):
        self.restaurantName = restaurantName
        self.cuisineType = cuisineType
        self.numberServerd = 0

    def describeRestaurant(self):
        print(f'{self.restaurantName}, {self.cuisineType}')

    def openRestaurant(self):
        print(f'{self.restaurantName} opening.')

    # 9-4
    def setNumberServed(self,numbers):
        self.incrementNumber(numbers)
        print(f'{numbers} people eat.')

    def incrementNumber(self,numbers):
        if not isinstance(numbers, int) or numbers <= 0:
            errMsg = 'Pleasse nter the positive integer.'
            raise Exception(errMsg)
        self.numberServerd = self.numberServerd + numbers


a = Restaurant('XiAn People', 'noodles')
a.setNumberServed(4)


# 9-3
class User():

    def __init__(self, firstName, lastName):
        self.firstName = firstName
        self.lastName = lastName
        self.fullName = f'{firstName} {lastName}'
        self.loginAttempts = 0

    def describeUser(self):
        print(f'First name: {self.firstName}')
        print(f'Last name: {self.lastName}')

    def greetUser(self):
        print(f'Hello {self.fullName}')

    # 9-5
    def incrementLoginAttempts(self):
        self.loginAttempts = self.loginAttempts + 1

    def resetLoginAttempts(self):
        self.loginAttempts = 0


michael = User('Michael', 'Jackson')
michael.birth = 'August 29, 1958'
michael.describeUser()
michael.greetUser()
```

## 9-6..9

```python
# -*- coding: utf-8 -*-

#9-6
class IceCreamStand(Restaurant):

    def __init__(self, restaurantName, cuisineType):
        super().__init__(restaurantName, cuisineType)
        # -- or --
        # Restaurant.__init__(restaurantName, cuisineType)
        self.flavors = []

# 9-7
class Admin(User):

    def __init__(self, firstName, lastName) -> None:
        super().__init__(firstName, lastName)
        self.privileges = Privileges()


# 9-8
class Privileges():

    def __init__(self) -> None:
        self.privileges = ['can add post', 'can delete post', 'can ban user']

    def showPrivileges(self):
        print(self.privileges)


a = Admin('Yong', 'SangUn')
a.privileges.showPrivileges()
-- output --
['can add post', 'can delete post', 'can ban user']

# 9-9
pass
```

## 9-10..12

import

pass

## 9-13..15

```python
# -*- coding: utf-8 -*-

# 9-13
from collections import OrderedDict

favoriteLanguages = OrderedDict()
favoriteLanguages['jen'] = 'python'
favoriteLanguages['sarah'] = 'c'
favoriteLanguages['edward'] = 'ruby'
favoriteLanguages['phil'] = 'python'

print(favoriteLanguages)

# 9-14
from random import randint

class Die():

    def __init__(self, sides=6) -> None:
        self.sides = sides

    def roll_die(self):
        x = randint(1, self.sides)
        print(x)

if __name__ == "__main__":
    die = Die()
    die10 = Die(10)
    die20 = Die(20)

# 9-15
http://pymotw.com/
```

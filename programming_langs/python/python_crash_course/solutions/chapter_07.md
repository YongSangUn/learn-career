# chapter 07

## 7-1..3

```python
# -*- coding: utf-8 -*-

# 7-1
_car = 'Lamborghini'

carRent = input('What car do you want to rent: ')
print(f'Let me see if i can find you a {carRent}.')

# 7-2
dineNums = int(input('How many people dine: '))
if dineNums > 8:
    print('No vacant tables.')
else:
    print('Yes.')

# 7-3
num = int(input('Enter the num.'))
if nums % 10 == 0:
    print('Divisible by 10.')
else:
    print('Not divisible by 10.')
```

## 7-4..7

```python
# -*- coding: utf-8 -*-

# 7-4
firstMsg = 'What do you want to add to the pizza: '
nextMsg = 'Ok, And: '

foods = input(firstMsg)
while foods.lower() != 'quit':
    print(f'Add {foods}.')
    foods = input(nextMsg)

active = True
while active:
    foods = input(firstMsg)
    if foods.lower() == 'quit':
        active = False
    else:
        print(f'Add {foods}.')

while True:
    foods = input(firstMsg)
    if foods.lower() == 'quit':
        break
    else:
        print(f'Add {foods}.')


# 7-5
age = input('How old are you? ')

while str(age).lower() != 'quit':
    try:
        age = int(age)
    except:
        age = input('How old are you? ')
    if 3 < age <= 12:
        pay = 10
    if age > 12:
        pay = 15
    print(f'{pay} $.')
    age = input('How old are you? ')

# 7-6
# see 7-4

# 7-7
import time
n = 0
while True:
    n += 1
    time.sleep(1)
    print(f'{n} s.')
```

## 7-8

```python
# -*- coding: utf-8 -*-

sandwichOrders = ['kdj', 'mdl', 'bsk', 'pastrami', 'pastrami', 'pastrami']
finishedSandwiched = []

# 7-9
while 'pastrami' in sandwichOrders:
    sandwichOrders.remove('pastrami')
else:
    print(f'pastrami none.')

# 7-8
while sandwichOrders:
    sw = sandwichOrders.pop()
    print(f'I made your {sw} sandwich.')
    finishedSandwiched.append(sw)

print(f'All done: {finishedSandwiched}')

# 7-10
place = input('Where would you want visit?')
print(place)
pass
```

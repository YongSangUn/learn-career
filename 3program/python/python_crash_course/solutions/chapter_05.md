# chapter 05

## 5-1..2

```python
>>> 0 / 2 ==0
True
>>> 1 == 2
False
>>> -10 // 3 == -3
False
>>> -10 // 3 == -4
True
>>> 5 in range(10)
True
>>> '' == None
False
>>> 'python' == 'Python'
False
>>> 'python' == 'Python'.lower()
True
>>> 1 > 2 and 2 >= 2
False
>>> 7 in [i for i in range(20) if i % 2 == 1]
True
```

## 5-3..7

```python
# -*- coding: utf-8 -*-

# 5-3..5
alien_color = 'red'
points = 0
if alien_color == 'green':
    print += 5
    print('Add 5 points by shot.')
elif alien_color == 'yellow':
    print += 10
    print('Add 10 points.')
elif alien_color == 'red':
    print += 15
    print('Add 15 points.')

# 5-6
if age < 2:
    print('Baby.')
elif 2 <= age < 4:
    print('Learnning walk.')
elif 4 <= age < 13:
    print('Child.')
elif 13 <= age < 20:
    print('Yong child.')
elif 20 <= age < 65:
    print('Man.')
elif age >= 65:
    print('Old man.')

# 5-7
pass
```

## 5-8

```python
# -*- coding: utf-8 -*-

## 5-8..9
users = ['Tom', 'Jerry', 'Jack', 'Ryan', 'Admin']

if users:
    print('We need to find some users!')

for user in users:
    if user == 'Admin':
        message = f'Hello {user}, Would you like to see a status reports?'
    else:
        message = f'Hello {user}, thank you for logging in again.'
    print(message)

## 5-10
current_users = users[:]
new_users = ['Tom', 'Kobe', 'Shark', 'Tim', 'JACK']

for user in new_users:
    if user.title() in current_users:
        print(f'The user-name {user} is already used, plz enter the other name.')
    else:
        print('You can use this name.')

## 5-11
nums = range(1, 10)

for num in nums:
    if num == 1:
        end = 'st'
    elif num == 2:
        end = 'nd'
    elif end == 3:
        end = 'rd'
    else:
        end = 'th'
    print(f'{num}{end}')
```

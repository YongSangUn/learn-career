# chapter 03

## 3-1..2

```python
>>> names = ['zhang3', 'li5', 'wang5']
>>> names = ['zhangsan', 'lisi', 'wangwu']
>>> for name in names:
...     msg = f'Hi {name}, How are you?'
...     print(msg)
...
Hi zhangsan, How are you?
Hi lisi, How are you?
Hi wangwu, How are you?
```

## 3-3

```python
>>> commuting = ['bike', 'subways', 'bus']
>>>
>>> print(f'A {commuting[0]} is a pedal-powered two-wheeled vehicle.')
A bike is a pedal-powered two-wheeled vehicle.
>>> print(f'The word \'{commuting[1]}\' refers to the whole system within a particular city.')
The word 'subways' refers to the whole system within a particular city.
>>> print(f'I take the {commuting[2]} to work every morning.')
I take the bus to work every morning.
```

## 3-4..7 & 3-9

```python
# -*- coding: utf-8 -*-

## 3-4
guests = ['dehua', 'yuyan', 'chaowei']

## 3-5
cannotGuest = 'dehua'
insertGuest = 'chenwu'

for index, value in enumerate(guests):
    if value == cannotGuest:
        print(f'{cannotGuest.title()} cannot come, the new guest is {insertGuest.title()}.')
        guests[index] = insertGuest

## 3-6
newGuest1 = 'yanzu'
newGuest2 = 'loong'
newGuest3 = 'zidan'

guests.insert(0, newGuest1)
guests.insert(len(guests) // 2, newGuest2)
guests.append(newGuest3)

print('I found a biggest table, because more people came.')
## 3-9
print(f'{len(guests)} people in total.')

for guest in guests:
    msg = f'Hi {guest.title()}, I want invite you to dinner.'
    print(msg)

## 3-7
print('The table can not arrive in time, only two people can be invited.')

while len(guests) > 2:
    guest = guests.pop()
    msg = f'Sorry {guest}, i can not invite you because the table won\'t arrive in time.'
    print(msg)
else:
    msg = f'Hi {guests[0]}, you are still on the invite list.'
    print(msg)
    del guests[0]
    print(msg)
    del guests[0]
```

## 3-8

```python
# -*- coding: utf-8 -*-

cities = ['beijing', 'shanghai', 'guangzhou', 'kunming', 'xizang']

print(f'About the original list of cities I am going to:\n\t{cities}')

print(f'Sorted() list:\n\t{sorted(cities)}')
print(f'Sorted(reverse) list:\n\t{sorted(cities, reverse=True)}')
print(f'Original list:\n\t{cities}')

cities.reverse()
print(f'Reverse list:\n\t{cities}')
cities.reverse()
print(f'Reverse list:\n\t{cities}')

cities.sort()
print(f'Sort list:\n\t{cities}')
cities.sort(reverse=True)
print(f'Sort list:\n\t{cities}')
```

## 3-10..11

```python
# -*- coding: utf-8 -*-

lans = ['cpp', 'java', 'go', 'python', 'rust']

lans[-1] = 'ruby'
lans.append('javascript')
lans.insert(0, 'c#')
lans.pop()
del lans[-3]
lans.remove('java')

sorted(lans)
sorted(lans, reverse=True)
lans.reverse()
lans.sort()
lans.sort(reverse=True)

## 3-11
try:
    lans[99]
except IndexError as e:
    print(e)
```

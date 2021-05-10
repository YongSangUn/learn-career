# chapter 04

## 4-1..2

```python
# -*- coding: utf-8 -*-

pizzas = ['apple', 'banana', 'orange']
for pizza in pizzas:
    print(f'I like {pizza} pizza.')
print('I really love pizza.')

animals = ['dog', 'cat', 'birds']
for animal in animals:
    print(f'A {animals} would make a great pet.')
print('Any of these animals would make a great pet!')

```

## 4-3..9

```python
# -*- coding: utf-8 -*-

# 4-3
nums20 = list(range(1,21))

# 4-4..5
numsM = list(range(1,1000001))
numsMMin = min(numsM)
numsMMax = max(numsM)
numsMSum = sum(range(1000000))

# 4-6
oddNums30 = [i for i in range(1,21,2)]

# 4-7
divide3In30 = [i for i in range(1,31) if i % 3 == 0]

# 4-8..9
cube10 = [i**3 for i in range(1,11)]

for i in cube10:
    print(i, end=' ')
```

## 4-10

```python
# -*- coding: utf-8 -*-

cube10 = [i**3 for i in range(1,12)]

first3 = cube10[:3]

middle = len(cube10) // 2
middle3 = cube10[middle - 1:middle + 2]

last3 = cube10[-3:]

print(cube10)
print(first3, middle3, last3)
```

## 4-11..12

pass

## 4-13

```python
# -*- coding: utf-8 -*-

foods = ('fried rice', 'noodles','fruit','pizza','cake')

newFoods = list(foods)

newFoods[0] = 'biscuits'
newFoods[1] = 'rice flour'

foods = set(newFoods)
```

## 4-14..15

[PEP 8 -- Style Guide for Python Code](https://python.org/dev/peps/pep-0008/)

[Google Python Style Guide](https://google.github.io/styleguide/pyguide.html)

# chapter 06

## 6-1..3

```python
# -*- coding: utf-8 -*-

# 6-1
good_man = {
    'first_name': 'SangUn',
    'last_name': 'Yong',
    'age': 17,
    'city': 'ShangHai'
}
for k, v in good_man.items():
    print(f'{k}: {v}')

# 6-2
numsLike = {
    'Tom': 4,
    'Jerry': 10,
    'Kobe': 24,
    'Jordan': 23,
    'SangUn': 17
}

# 6-3
words = {
    'print': 'echo something.',
    'dict': 'directory',
    'del': 'delete',
    '>': 'lt'
}
for k, v in words.items():
    print(f'{k}:\n{v}')
```

## 6-4..6

pass

## 6-7..12

```python
# -*- coding: utf-8 -*-

## 6-7
peoples = [
    {
        'first': 'Tom',
        'last': 'cat',
        'location': 'en'
    },
    {
        'first': 'Jerry',
        'last': 'mouse',
        'location': 'en'
    },
    {
        'first': 'Winnie',
        'last': 'Bear',
        'location': 'en'
    },
]
for index, people in enumerate(peoples):
    print(f'==> No.{index + 1}')
    for k, v in people.items():
        print(f'{k}: {v}')

# 6-8..12
pass
```

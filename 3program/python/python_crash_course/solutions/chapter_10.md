# chapter 10

[chapter 10 source](https://github.com/ehmatthes/pcc_2e/tree/master/chapter_10)

## 10-3..5

```python
# -*- coding: utf-8 -*-

# 10-3..4
logFiles = 'guest_book.txt'

with open(logFiles, 'w') as f:
    while True:
        name = input('Plz enter your name(Enter \'q\' to quit): ')
        if name == 'q':
            break
        f.write(f'{name}\n')

# 10-5

file = 'love_python.txt'

with open(file, 'w') as f:
    while True:
        reason = input('What is the reason you love python: ')

        if reason == 'q':
            break

        f.write(f'{reason}\n')
```

## 10-6..10

```python
# -*- coding: utf-8 -*-

# 10-6..7
while True:
    try:
        num1 = int(input('Plz enter the 1st nums: '))
    except ValueError:
        print('Plz enter the integer.')
    else:
        break

while True:
    try:
        num2 = int(input('Plz enter the 2rd nums: '))
    except ValueError:
        print('Plz enter the integer.')
    else:
        break

sum = num1 + num2
print(f'{num1} + {num2} = {sum}')

# 10-8
files = ['cats.txt', 'dogs.txt']
for file in files:
    try:
        with open(file, 'r') as f:
            pet_names = f.read()
    except FileNotFoundError:
        print(f'The file {file} is not exist.')
        # 10-9
        pass
    else:
        print(pet_names)

# 10-10
file_url = 'https://gutenberg.org/files/65355/65355-0.txt'

file = "65355-0.txt"
# The encoding of the file is ascii, and the reading mode is 'b'.
with open(file, 'rb') as f:
    contents = f.read()

contents.lower().count(b'the')
# Outout: 994
```

## 10-11..13

```python
# -*- coding: utf-8 -*-

# 10-11..12
def getStoredNum(user):
    file = f'{user}.txt'
    try:
        with open(file, 'r') as f:
            favNum = f.read()
    except FileNotFoundError:
        return None
    else:
        return favNum

def getNewNum(user):
    file = f'{user}.txt'
    with open(file, 'w') as f:
        favNum = input(f'Hi {user} Enter your favorite numbers: ')
        f.write(f'{favNum}')
    return favNum

def main():
    user = input('Please enter your name: ')
    favNum = getStoredNum(user)
    if favNum is None:
        favNum = getNewNum(user)
    print(f'Hi {user}, your favorite number is {favNum}.')

main()

# 10-13
pass
```

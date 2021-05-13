# chatper 08

## 8-1..5

[实参和形参的区别](https://stackoverflow.com/questions/156767/whats-the-difference-between-an-argument-and-a-parameter):

- 实参(argument)：
  全称为"实际参数"是在调用时传递给函数的参数. 实参可以是常量、变量、表达式、函数等， 无论实参是何种类型的量，在进行函数调用时，它们都必须具有确定的值， 以便把这些值传送给形参。 因此应预先用赋值，输入等办法使实参获得确定值。

- 形参(parameter)：
  全称为"形式参数" 由于它不是实际存在变量，所以又称虚拟变量。是在定义函数名和函数体的时候使用的参数,目的是用来接收调用该函数时传入的参数.在调用函数时，实参将赋值给形参。因而，必须注意实参的个数，类型应与形参一一对应，并且实参必须要有确定的值。

形参在函数的声明中是变量，实参是传递给函数的该变量的实际值。

```python
# -*- coding: utf-8 -*-

# 8-1..2
def displayMessage(message):
    print(message)

dispalyMessage('hello python.')

# 'hello python.' 实参
# message         形参

# 8-3-4
def makeShirt(size, words='I love Python.'):
    print(f'Make a {} T-shirt with the word "{words}"')

makeShirt('Big')
makeShirt('Medium', 'I love Golang.')

# 8-5 pass
```

## 8-6..8

```python
# -*- coding: utf-8 -*-

# 8-6
def cityCountry(city, country):
    return f'{city.title()}, {country.title()}'

# 8-7
def makeAlbum(singer, description, songNums):
    album = {
        'singer': singer,
        'description': description
    }
    if songNums:
        album['song numbers'] = songNums

    return album

# 8-8
while True:
    print('Enter the album\'s singer, description and the numbers of the album.'
        + '\n(enter \'q\' to quit)')
    singer = input("singer: ")
    if singer == 'q':
        break

    description = input('description: ')
    if description == 'q':
        break

    songNums = input('the numbers of the album: ')
    if songNums == 'q':
        break

    album = makeAlbum(singer, description, songNums)
    print(album)
```

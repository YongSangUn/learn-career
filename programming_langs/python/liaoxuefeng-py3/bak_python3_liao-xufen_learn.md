[toc]

# 廖雪峰 python3 教程

教程地址：
<https://www.liaoxuefeng.com/wiki/1016959663602400>

## 第一个 python 程序

- 命令行模式  
直接执行 `.py` 文件。
- python 交互模式
直接输入代码，执行后立刻得到结果。

### 输入和输出

>Input/Output, 输入输出，简称IO。

- 输出
`print()` 可以向屏幕输出指定的文字，可以接受多个字符串，用“,”隔开(遇到逗号会输出一个空格)，就可以一起输出：

```python
>>>print("hello", "world!")
hello world!
```
  
可以漂亮的输出运算 `100+200`

```python
>>> print("100 + 200 =", 100+200)
100 + 200 = 300
```

- 输入
需要用户输入一些字符串，使用 `input()` ,用户输入并存入变量中。

```python
>>> name = input()
jake
>>> name
'jake'
# 调用变量
>>> print("hello", name) 
hello jake

# 为了方便添加提示信息
>>> name = input('please enter your name: ')
please enter your name: jake
>>> print("hello,",name)  
hello, jake
```

## Python 基础

```python
# print absolute value of an integer:
a = 100
if a >= 0:
    print(a)
else:
    print(-a)
```

规范：

- `#` 为注释
- 采用**4个空格**缩进，文本编辑器中，设置 TAB 为4 个空格。
- 大小写敏感

### 数据类型和规范

- 数据类型
python 中能够直接处理的数据类型
  - 整数
  - 浮点数
  也就是小数，1.23，3.14，-5.12，或者更高位的数：10 用 e 代表， 例如1.23e9，12.3e8，1.23e-5。
  - 字符串
  - 转义
  转义字符 `\` ,`\n` 换行，`\t` 制表符，`\\` 表示 `\` 本身。  
  
```python
>>> print('\\\t\\\n\\\t\\')  
\       \
\       \

# 如果字符串内的内容都要转义，可以使用 {r"str"}, str 为字符串。
>>> print(r'\\\t\\\n\\\t\\')
\\\t\\\n\\\t\\

# python 只允许使用 '''...''' 的格式来表示多行内容。''' 代表了开始符 和 结束符。
# ... 为提示符，不是代码的部分。
>>> print('''line1
... line2
... line3''')
line1
line2
line3

# 多行字符串'''...'''还可以在前面加上 r 使用
# _*_ coding:utf-8 _*_
print(r'''hello,\n\\\t
world''')
# 输出结果为：
hello,\n\\\t
world
```

- 接“数据类型”
  - 布尔值
  布尔值只有 `True` 和 `False` ，两种值，可以进行 `and` ，`or` 和 `not` 运算。进场应用于条件判断中。
  - 空值
  空值是 python 里一个特殊的值，用 `None` 表示。`None` 不是 0，0 是有意义的，而 `None` 是一个特殊的空值。

- 变量
变量可以是任何数据类型，变量名必须是**大小写英文，数字和下划线 `_` 的组合，且不能用数字开头**。

```python
>>> a = 123 # a是整数
>>> print(a)
123
>>> a = 'ABC' # a变为字符串
>>> print(a)
ABC
# 这种变量本身不固定的语言称之为 动态语言，与之对应的是 

# 在定义变量时必须指定变量类型，如果赋值的时候类型不匹配，就会报错的 静态语言。
int a = 123; // a是整数类型变量
a = "ABC"; // 错误：不能把字符串赋给整型变量

# 动态语言更加灵活
```

变量之间也可以相互赋值，但不是变量永远相等。  
> 创建一个变量会在 内存中 添加 一个字符串 和 一个变量，并将变量指向字符串。赋值时，改变指针指向，而不是变量本身。  
> 对变量赋值a = b是把变量a指向真正的对象，该对象是变量b所指向的。随后对变量b的赋值不影响变量a的指向。
![str](https://www.liaoxuefeng.com/files/attachments/923792191637760/)

- 常量
不能变的变量。例如 数学常数 `π` ，通常用全部大写的变量名：

```python
PI = 3.14159265359
```

但这只是一个习惯用法，不能保证 `PI` 不会改变。
> 注意：Python的整数没有大小限制，而某些语言的整数根据其存储长度是有大小限制的，例如Java对32位整数的范围限制在-2147483648-2147483647。
> Python的浮点数也没有大小限制，但是超出一定范围就直接表示为inf（无限大）。

整数的除法是精确的:

```python
>>> 10 / 3
3.3333333333333335

# 整数除也会显示浮点数。
>>> 9 / 3
3.0

# // 称为为 地板除，去除余数
>>> 10 // 3
3

# % 为 余数运算。
>>> 10 % 3
1
```

### 字符串和编码

- python 的字符串
Python 3版本中，字符串是以Unicode编码的，也就是说，Python的字符串支持多语言,

```python
- ord() 获取字符的整数表示    chr() 编码转换成字符
>>> ord('a')
97
>>> ord('啊')
21834
>>> chr(97)
'a'
>>> chr(21834)
'啊'

# python3 中，文本总是 Unicode。
`byte` 类型的数据用 b 前缀+''.
x = b'ABC'

- encode: str 转 bytes,   decode: bytes 转 str 。
>>> '€20'.encode('utf-8')
b'\xe2\x82\xac20'
>>> b'\xe2\x82\xac20'.decode('utf-8')
'€20'

- len() 计算 str 的字符数，换成 bytes, 就换成了计算字节数。
>>> len(b'ABC')
3
>>> len(b'\xe4\xb8\xad\xe6\x96\x87')
6
>>> len('中文'.encode('utf-8'))
6
```

在操作字符串时，我们经常遇到str和bytes的互相转换。为了避免乱码问题，应当始终坚持使用UTF-8编码对str和bytes进行转换。在行首指定，但是必须保证编辑器使用 utf-8 编码。

```shell
#!/usr/bin/env python3
# -*- coding: utf-8 -*-  

这样只是输出中文不会用乱码。
```

### 格式化

`%` 运算符就是用来格式化字符串的。在字符串内部，%s表示用字符串替换，%d表示用整数替换，有几个%?占位符，后面就跟几个变量或者值，顺序要对应好。如果只有一个%?，括号可以省略。

```python
>>> 'hello, %s!' % 'world' 
'hello, world!'
>>> 'Hi, %s, i m %d, and %s.' % ('Loong', 18 , 'you') 
'Hi, Loong, i m 18, and you.'

# 使用 %% 转义来表示 % 。

```

- 占位符类型:

| 占位符 | 替换内容     |
| ------ | ------------ |
| %d     | 整数         |
| %f     | 浮点数       |
| %s     | 字符串       |
| %x     | 十六进制整数 |

- 另一种 fomat() 方式，使用 {0}, {1}, {2}...的方式

```python
>>> '{0} have a {1:.1f}$.'.format('Tom', 123.12) 
'Tom have a 123.1$.'

格式为 '......'.format('..','..')
```

- 练习

```python
- 小明的成绩从去年的72分提升到了今年的85分，请计算小明成绩提升的百分点，并用字符串格式化显示出'xx.x%'，只保留小数点后2位：

# _*_ coding: utf-8 _*_
s1 = 72
s2 = 85
r = (s2-s1)/s1
print('This merger of Xiaoming\'s performance improvement %.18f%%' % r)
This merger of Xiaoming's performance improvement 0.18%
```

### list 列表  和  tuple 元组

- list，有序的集合，可以随时添加和删除其中的元素。

```python
name = ['yong','sang','un']
>>> name = ['yong','sang','un']
>>> name
['yong', 'sang', 'un']
# 编号从 0 开始。
>>> name[0]
'yong'

# 最后一个元素可以用 [-1]，以为倒数的意思。
>>> name[-1]
'un'
```

- 增、删、改元素

```python
# 增加
>>> name.append('long')
>>> name
['yong', 'sang', 'un', 'long']
>>> name.insert(1, 'loong')     # 插入到指定的索引，用    xxx.append(n, 'xxx')
>>> name
['yong', 'loong', 'sang', 'un', 'long']

# 删除
>>> name.pop()   # 默认删除最后一个
'long'
>>> name
['yong', 'loong', 'sang', 'un']
>>> name.pop(1)   # 指定删除索引位置的元素。
'loong'
>>> name
['yong', 'sang', 'un']

# 修改
>>> name[1] = 'loong'
>>> name
['yong', 'loong', 'un']
```

- list 中的元素可以是不同的数据类型，

```python
>>> A = ['name', 1, True]
>>> B = ['c', 'python',['centos', 'shell'], 'java']     # 元素也可以是一对 list
>>> C = ['centos', 'shell']
['centos', 'shell']
>>> C[1]
'shell'
>>> B[2][1]     # 也可以用这种方式获得 'shell' 元素。
'shell'
>>>
```

- ruple 元组












<a href="#jump" target="_self"><p align="right"><u>返回顶部</u></p></a>

<span id="bottom">
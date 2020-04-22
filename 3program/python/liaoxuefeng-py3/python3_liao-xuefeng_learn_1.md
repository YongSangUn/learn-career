# 廖雪峰 python3 教程 笔记 1

[toc]

## 第一个 python 程序

### 输入和输出

- 输出 print()

```python
# print()函数，可以接受多个字符串，逗号 [,] 会输出一个空格，
>>> print('My', 'name is', 'Tom.')
My name is Tom.

# 没有逗号则不输出内容
>>> print('My''name is''Tom.')
Myname isTom.
```

- 输入 input()

```python
# 把输入的内容存入变量 "name" 中
>>> name = input('Please enter your name: ')
Tom         # 此为输入的内容
>>> print('hello,', name)
hello, Tom
```

## python 基础

- 缩进
  python 使用缩进来组织代码块，无比遵守约定的习惯，使用 4 个空格缩进

- TAB
  文本编辑器中，需要设置 TAB 自动转换为 4 个空格，

- 大小写敏感

### 数据类型和变量

#### 数据类型

- 整数：
  `100`, `-80`, `0xff00`, `oxa5bc`
- 浮点数：
  `1.23`, `1.23e9(1.23x10^9)`, `1.2e-5`
- 字符串：
  单引号 `'` 或者 `"` 括起来的任意文本，注意单双引号的赋值。例如：`'abc'`, `"I'm OK"`, `'I\'m \"OK\"!'(I'm "OK"!)`

字符转义，可以使用 r'' 表示 '' 内部不转义

```python
>>> print('\\\t\\')
\    \
>>> print(r'\\\t\\')
\\\t\\
```

如果字符串内部又很多换行，用 \n 写在一行不方便阅读，python 允许 `'''...'''` 的格式便是多行内容：

```python
>>> print('''line1
... line2             # ... 为提示符，不属于代码的一部分
... line3''')
line1
line2
line3
```

- 布尔值
  布尔值支持， `or`, `not`, 等运算。多用于条件判断中。

- 空值
  用 `None` 表示，不能理解为 0，0 是有意义的。

#### 变量 & 常量

变量可以是任何数据类型，变量名必须是大小写英文、数字和 `_` 的组合，且不能用数字开头。

- 动态语言
  变量本身类型不固定的语言，变量可以从整数变为字符串。

```python
a = 123       # a 是整数
print(a)
a = "ABC"     # a 是字符串
print(a)
```

- 静态语言 (Java)

```python
int a = 123;      # 定义变量类型为整数
a = 'ABC'         # 提示报错，不能把字符串赋值给整型变量
```

如何理解变量在计算机内存中的表示？

```python
a = 'ABC'
# 赋值时，python 解释器的操作
  1. 在内存中创建了一个 'ABC' 的字符串；
  2. 在内存中创建了一个名为 a 的变量，并把它指向 'ABC'.

b = a
# 变量 a 赋值给 b 时，实际上时把变量 b 指向变量 a 所指的数据。

a = 'DEF'
# 内存中新建一个 'DEF' 变量，将变量 a 指向这个变量；而变量 b 不变，还是指向原来的 'ABC'。
```

- 常量

就是不能变的变量，比如常数 π 就是一个常量，通常用 `全部大写` 的变量名表示。

```python
## 常数 π ：
PI = 3.14159265359    # 但它实际上还是一个变量，所以最好不要改变它的值
```

整数运算, python 的运算时属于精确运算，除法的结果时浮点数。

```python
# 精确运算
>>> 9 / 3
3.0

# 地板除 (整除)
>>> 10 // 3
3

# 余数
>>> 10 % 3
1
```

### 字符串编码

- 字符编码
  略

- 格式化

```python
### 字符串替换
>>> 'My name is %s, I am %d years old.' % ('Tom', 18)
My name is Tom, I am 18 years old.

# % 用来格式化字符串的，常用的占位符有:
  %s    字符串，它会把任何数据类型都转化为字符串
  %d    整数替换
  %f    浮点数，保留小数点后面六位有效数字
  %x    十六进制整数
  %e    保留小数点后面六位有效数字，指数形式输出
  %g    在保证六位有效数字的前提下，使用小数方式，否则使用科学计数法

### 格式化整数和浮点数
%d    普通输出，%d 表示十进制整数
%10d   左对齐，占位符 10 位。
%-10d  左对齐，占位符 10 位。
%02d  数据宽度为 2 ，数据宽度不足时用 0 填补。
%.2d  和 %02d 一样。

>>> '|%d, |%3d, |%04d, |%.4d|' % (11, 12, 13, 14)
'|11, | 12, |0013, |0014|'

关于格式化输出，我会再写一篇文。

```

### list & tuple

- list 列表

```python
# 获取 list 的个数：
>>> list = ["abc", "def", "ghi"]
len(list)

# list 的索引，可以使用 负数 作索引
>>> list[-1]
'ghi'

### 增 删 插入元素。
# 增加
>>> list.append('jkl')        # 附加到最后
>>> list.insert(i, 'ghi')     # i 为索引位置
>>> list.pop()                # 移除最后的元素
>>> list.pop(i)               # i 为索引位置

### 列表中的元素可以是任何数据类型，包括另一个列表
>>> list = ['apple', 123, True, ['python', 'java'], 'php']
>>> len(list)
5
# 所以这是一个二维列表,当然还有更多维的列表
>>> list[3][1]
'java'
```

- tuple

另一种有序列表叫元组，tuple 和 list 非常类似，但 tuple 一旦初始化就不能修改（每个元素的指向即本身不能变，但是元素内可以改变指向）。

```python
### tuple 定义时，元素就被确定下来了，不能修改。
>>> tuple = ("qwe", 1, True, ['A', 'B'])
>>> tuple[3][0] = 'X'                     # 但是元组内的 list 是可变的。
>>> tuple = ()                            # 定义空元组

>>> tuple = ("only_1",)                   # 只有一个元素的时候必须加一个 “,” 消除歧义。
>>> tuple
'only_1'
>>> tuple = ("only_1",)
>>> tuple
('only_1',)
```

### 条件判断

练习：

```python
# -*- coding: utf-8 -*-
'''
练习：
小明身高1.75，体重80.5kg。请根据BMI公式（体重除以身高的平方）帮小明计算他的BMI指数，并根据BMI指数：
    低于18.5：过轻
    18.5-25：正常
    25-28：过重
    28-32：肥胖
    高于32：严重肥胖
用if-elif判断并打印结果。
'''
name = input("Please enter your name: ")
height = float(input("Please enter your height(M): "))
weight = float(input("Please enter your weight(Kg): "))

# input() 输入的是字符串，需要转换位浮点数。
BMI = float("%.3f" % (weight / height**2))      # 保留2位小数

'''
遇到报错： "can only concatenate str (not "int") to str"
python 拼接字符串的时候，不会将 int 或者 float 转换为 str 类型.
print(1+"a")  改为  print(str(1)+"a") 即可。
'''
print("hello " + name + ", your BMI index is " + str(BMI) + ".")

if BMI < 18.5:
    print("Hello", name + ", you are underweight.")
elif 18.5 <= BMI < 25:
    print("Hello", name + ", your weight is normal.")
elif 25 <= BMI < 28:
    print("Hello", name + ", you are overweight.")
elif 28 <= BMI < 32:
    print("Hello", name + ", you are obese.")
elif BMI >= 32:
    print("Hello", name + ", you are very heavy.")
```

### 循环

- 整数序列-列表

```python
### range()函数返回一个数字序列，默认情况下从0开始，默认情况下以1递增，并以指定的数字结尾。
>>> list(range(5))
[0, 1, 2, 3, 4]
>>> list(range(1,5))        # 以 1 开始，5-1 结束。
[1, 2, 3, 4]
>>> list(range(2,2))
[]
    # range(2,2) 为什么不报错：
    # range(2, 2)返回一个空的迭代器，for循环作用于空的迭代器上，一次也不会执行，而是直接结束。空迭代器是合法的，不会报错。
>>> list(range(2,10,2))     # 以 2 开始，10-1 结束，2 递增。
[2, 4, 6, 8]
```

- 其他的笔记详见练习：
  [practice_while_for_break.py](/4program/3python/0python_work/practice_while_for_break.py)

要特别注意，不要滥用 break 和 continue 语句。break 和 continue 会造成代码执行逻辑分叉过多，容易出错。大多数循环并不需要用到 break 和 continue 语句。

### 使用 dict 和 set

#### dict

python 中内置了字典：dict (dictionary)，其他语言中也称为 map，使用 键-值 (key-value) 存储。

```python
>>> d = {'abc': 10, 'def': 20, 'ghi': 30}
>>> d['abc']
10
>>> d['jkl'] = 40                                 # 数据可通过 key 放入 dict 中。
>>> d
{'abc': 10, 'def': 20, 'ghi': 30, 'jkl': 40}
# value 也可以被重新赋值。

# 判断 key 是否存在
>>> 'xyz' in d
False

# 删除 key，对应的 value 也会被删除。
>>> d.pop('def')
20
>>> d
{'abc': 10, 'ghi': 30, 'jkl': 40}
```

- 和 list 比较，dict 有以下几个特点：

  - 查找和插入的速度极快，不会随着 key 的增加而变慢；
  - 需要占用大量的内存，内存浪费多。

- 而 list 相反：

  - 查找和插入的时间随着元素的增加而增加；
  - 占用空间小，浪费内存很少

dict 的 key 必须是**不可变对象**。字符串、整数等都是不可变的，因此，可以放心地作为 key。而 list 是可变的，就不能作为 key.

#### set

set 和 dict 类似，也是一组 key 的集合，但不存储 value。由于 key 不能重复，所以，在 set 中，没有重复的 key。

```python
### key 不能重复
>>> s = set([1, 1, 2, 2, 3, 3])
>>> s
{1, 2, 3}

# 增 删
>>> s.add(4)
>>> s.remove(3)
>>> s
{1, 2, 4}

# 集合可以作交集和并集
>>> s2 = set([2,3,4])
>>> s1 = set([1,2,3])
>>> s2 = set([2,3,4])
>>> s1 & s2
{2, 3}
>>> s1 | s2
{1, 2, 3, 4}
```

set 的原理和 dict 一样 同样不可以放入可变对象，因为无法判断两个可变对象是否相等，也就无法保证 set 内部“不会有重复元素”

#### 不可变对象

str 为不可变对象，list 为可变对象

```python
>>> a = ['b', 'a', 'c']
>>> a.sort()
>>> a
['a', 'b', 'c']                 # list a的对象已更改
```

不可变对象

```python
>>> a = 'abc'
>>> a.replace('a', 'A')
'Abc'
>>> a
'abc'                           # str  a 的对象没有更改

>>> b = a.replace('a', 'A')
>>> b
'Abc'
>>> a
'abc'
```

- 分析:

  - a 是变量，'abc' 才是字符串对象，而 `a.replace()` 实际上是作用在 字符串对象 'abc' 上，而并没有修改 'abc' 的值。
  - `a.replace()` 就是 字符串 'abc' 利用 replace() 创建一个新的字符串 'Abc'，而定义一个新的变量 b 指定到它，b 的内容就变成了 'Abc'。
  - 调用对象自身的任意方法都不会修改对象本身。

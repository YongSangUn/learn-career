# 廖雪峰 python3 教程 笔记 2

## 函数

```python
## 函数抽象,
# 例：求和函数 (1^2+1)+(2^2+1)+(3^2+1)....+(100^2+1) 抽象为：
100
∑(n^2 + 1)
n=1
```

### 调用函数

调用函数，传入的参数必须满足：数量、参数类型正确。列入求绝对值的函数： abs() 只能传入一个 数字 的参数。

```python
>>> abs(123)
123
>>> abs(-456)
456
>>> abs(-12.34)
12.34
>>> abc('a')
Traceback (most recent call last):
  File "<stdin>", line 1, in <module>
NameError: name 'abc' is not defined
```

- 数据类型的转换

int() 函数可以把其他数据类型转换为整数。

**函数名其实就是指向一个函数对象的引用，完全可以把函数名赋给一个变量，相当于给这个函数起了一个“别名”：**

```python
>>> abs=print       # 变量 abs 指向 print 函数
>>> abs(-20)        # 当然最好避免使用已存在的函数名作为变量，这样回产生异义。
-20
```

### 定义函数

定于一个函数需要使用 `def` 语句，依次写出 函数名、括号、括号中的参数 和 冒号 ":" ，然后再缩进块中编写函数体，函数的返回值用 `reture` 语句返回。

```python
### abstest.py 文件如下：

# -*- coding: utf-8 -*-
 def my_abs(x):
     if x >= 0:
         return x
     else:
         return -x
```

如果需要调用此函数，再文件所在目录下启动解释器，执行 `from abstest import my_obs` 来导入 my_abs() 函数。

- 空函数

什么都不做，可以在还没想好怎么写代码时，先让代码跑起来。

```python
def nop():
    pass

if age >= 18:
    pass

## 如果缺少了 pass, 函数执行就会出错。
```

- 参数检查

如果传入参数类型不对，函数会返回错误信息。

```python
>>> my_abs('a')
Traceback (most recent call last):
  File "<stdin>", line 1, in <module>
  File "<stdin>", line 2, in my_abs
TypeError: '>=' not supported between instances of 'str' and 'int'
>>> abs('a')
Traceback (most recent call last):
  File "<stdin>", line 1, in <module>
TypeError: bad operand type for abs(): 'str'
```

而 `my_abs` 函数并没有参数检查，如果会在 if 语句执行时失败。

参数检查可以使用内置的 isinstance() 实现：

```python
# -*- coding: utf-8 -*-
def my_abs(x):
    if not isinstance(x, (int, float)):
        raise TypeError('bad operand type')
    if x >= 0:
        return x
    else:
        return -x

# 执行：
>>> my_abs('A')
Traceback (most recent call last):
  File "<stdin>", line 1, in <module>
  File "<stdin>", line 3, in my_abs
TypeError: bad operand type

### isinstance 函数实例。
>>>a = 2
>>> isinstance (a,int)
True
>>> isinstance (a,str)
False
>>> isinstance (a,(str,int,list))    # 是元组中的一个返回 True
True
```

- 返回多个值

```python
# -*- coding: utf-8 -*-
import math

def move(x, y, step, angle=0):
    nx = x + step * math.cos(angle)
    ny = y + step * math.sin(angle)
    return nx, ny

x, y = move(100, 100, 60, math.pi / 6)
r = move(100, 100, 60, math.pi / 6)
print(x, y)
print(r)

# result:
151.96152422706632 130.0
(151.96152422706632, 130.0)
```

看似可以返回多个值，但是只是返回一个值，他们包含在一个 tuple 中，（语法上，返回一个 tuple 可以省略括号）

而多个变量可以同时接受一个 tuple，按位置赋值给对应的值。

实际上 python 函数返回多个值，其实就是返回一个 tuple。

### 函数的参数

- 位置参数

func(a,b) 有两个参数，调用函数时，传入的参数会顺序依次赋值对应的参数。

- 默认参数
  使用默认参数可以简化函数的调用，降低函数调用时的难度。使用时需要注意。
  - 必选参数在前，默认参数在后
  - 变化大的在前，变化小的在后，变化小的可以作为默认参数。

```python
def enroll(name, gender, age=6, city='ShangHai'):
    print('name:', name)
    print('gender:', gender)
    print('age:', age)
    print('city:', city)
```

> NOTE: 定义默认参数要牢记一点：默认参数必须指向不变对象！尤其是 **list** ，每一次调用都会调用系统中以改变的值，而不是取默认值。
> 变对象一旦创建，对象内部的数据就不能修改，这样就减少了由于修改数据导致的错误。

- 可变参数

```python
def calc(*nums):                 # *nums 代表可变参数
    s = 0
    for n in nums:
        s += n
    return s

calc(1, 2, 3)                   # 可以传入多个或者 0 个参数。在函数调用时，这些参数自动组装成一个 tuple.
nums = [1, 2, 3]
calc(*nums)                     # 或者使用 *nums 传入 list 中的每一个元素。
```

- 关键字参数

```python
def person(name, age, **other):
    print('name:', name, 'age:', age, 'other:', other)

# 可以传入人一个关键字参数
>>> person('Bob', 22, gender='F', job='program')
name: Bob age: 22 other: {'gender': 'F', 'job': 'program'}

# 也可以使用 **dict 取调用。
extra = {'city': 'Beijing', 'job': 'Engineer'}
>>> person('Tom', 22, **extra)
name: Tom age: 22 other: {'city': 'Beijing', 'job': 'Engineer'}

### **extra 代表 把 extra 这个字典的所有 key-value 用关键字传入函数。
### 注意 **other，other 只是获取 extra 的一份拷贝，对 other 的改动，不会影响到函数外的 extra 。
```

- 命名关键字参数

```python
def person(name, age, *, city='Beijing', job):
    print(name, age, city, job)

+ 上诉的参数总共有四个，前两个为位置参数（name, age），通过 * 分割符的，后两个为 命名关键字参数。
+ 如果函数定义中已经有了一个可变参数，后面跟着的命名关键字参数就不再需要一个特殊分隔符*了：
    def person(name, age, *arg, city='Beijing', job)：
```

- 参数组合
  参数定义的顺序必须是：
  - 必选参数、默认参数、可变参数、命名关键参数、和关键字参数

```python
def f1(a, b, c=0, *args, **kw):
    print(a, b, c, args, kw)

def f2(a, b, c=1, *, d, **kw):
    print(a, b, c, d, kw)

>>> f1(1,2,3, 'a', 'b', z='end')
1 2 3 ('a', 'b') {'z': 'end'}
>>> f2(1, 2, c=5, d=10, z='end')
1 2 5 10 {'z': 'end'}

### 当然可以使用 tuple 和 list 调用。
>>> arg = (1, 2, 3, 4)
>>> kw = {'d': 99, 'x': '$'}
>>> f1(*arg, **kw)
1 2 3 (4,) {'d': 99, 'x': '$'}
>>> arg = (1, 2, 3)
>>> f2(*arg, **kw)
1 2 3 99 {'x': '$'}
```

- 注意
  - \*args 是可变参数，args 接收的是一个 tuple；
  - \*\*kw 是关键字参数，kw 接收的是一个 dict。

### 递归函数

```python
def fact(n):
    if n==1:
        return 1
    return n * fact(n - 1)

>>> fact(5)
120

### 可以看到计算过程
===> fact(5)
===> 5 * fact(4)
===> 5 * (4 * fact(3))
===> 5 * (4 * (3 * fact(2)))
===> 5 * (4 * (3 * (2 * fact(1))))
===> 5 * (4 * (3 * (2 * 1)))
===> 5 * (4 * (3 * 2))
===> 5 * (4 * 6)
===> 5 * 24
===> 120
```

- 尾递归，防止栈溢出

```python
def fact(n):
    return fact_iter(n, 1)

def fact_iter(num, product):
    if num == 1:
        return product
    return fact_iter(num - 1, num * product)
```


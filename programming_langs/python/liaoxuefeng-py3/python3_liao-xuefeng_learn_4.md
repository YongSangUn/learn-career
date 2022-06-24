# 廖雪峰 python3 教程 笔记 4

## 函数式编程

函数式编程 (Functional Programming), 思维上接近数学的计算。

- 计算机 (Computer) 和 计算 (Computer) 的概念
  - cpu 执行的是加减乘除以及一些判断和跳转命令，所以最接近底层的是汇编语言，
  - 计算指的数学意义上的计算，越是抽象的计算，离计算机越远。

函数式编程的一个特点就是，允许把函数本身作为参数传入另一个函数，还允许返回另一个函数。

Python 对函数式编程提供部分支持。由于 python 允许使用变量，因此 python 不是纯函数式编程。

### 高阶函数

高阶函数 Higher-order function，

- 变量可以指向函数，且函数名也是变量

```python
>>> abs(10)
10
>>> f = abs              # f 指向 abs 这个变量，也可以使用 abs() 函数的功能
>>> f(10)
10
>>> abs = 10             # 实际上 abs 也可以看作一个变量，它指向了绝对值的函数，
>>> abs(-10)             # 当 abs 指向了另外一个值，它就不能调用 函数
Traceback (most recent call last):
  File "<stdin>", line 1, in <module>
TypeError: 'int' object is not callable
>>> f(-10)               # 而 f 指向的是函数，abs 的改变不会影响它的指向。
10
```

- 变量可以指向函数，函数可以接收变量，那么一个函数就可以接收另一个函数作为参数，这种函数称为高阶函数。

```python

def add(x, y, f):
    return f(x) + f(y)

x = -10
y = 5
f = abs
f(x) + f(y) ==> abs(-10) + abs(s) ==> 15
return 11
```

#### map / reduce



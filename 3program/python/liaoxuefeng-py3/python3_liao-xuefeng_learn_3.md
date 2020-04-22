# 廖雪峰 python3 教程 笔记 3

## 高级特征

1 行代码能实现的功能，决不写 5 行代码。请始终牢记，代码越少，开发效率越高。

### 切片

```python
L = list(range(100))        # 创建一个 0-99的整数列表。
L = list(range(1,101,2))    # 创建一个 1-100 间隔为 2 的列表。

### 切片可以针对 list 也可以针对字符串处理。
L[m:n]      表示从索引 m 开始，直到索引 n 为止，但不包括索引 n ，如果第一个索引是 0 ，可以省略。
            负数代表倒数切片，倒数第一个元素的索引为 -1 .
L[m:n:x]    m 和 n 同上，x 表示切片间隔。

## 讲解
L[:n]       m 省略表示从开头截取到索引 n 但不包括 n 为止；
L[m:]       n 省略表示从索引 m 开始截取到最后一个索引。
L[:]        m n 都省略表示截取全部。
# L[m:n:x] 中的x 表示的是按照 x 的切片间隔，所以也不难理解下面几个。
L[:n:x]
L[m::x]
L[::x]
```

### 迭代

任何可迭代对象都可以作用于 for 循环，包括我们自定义的数据类型，只要符合迭代要求，就可以使用 for 循环。

```python
>>> d = {'a': 1, 'b': 2, 'c': 3}
>>> for key in d:
...     print(key)
...
a
b
c
>>> for value in d.values():
...     print(value)
...
1
2
3
>>> for key,value in d.items():
...     print(key,value)
...
a 1
b 2
c 3

# 使用内置的 enumerate() 函数，将 list 变成 索引-元素对。
>>> for i, value in enumerate(['A', 'B', 'C']):
...     print(i, value)
...
0 A
1 B
2 C
```

### 列表生成式

list Comprehensions，python 内置的创建 list 的生成式。

```python
### 生成 [1x1, 2x2, 3x3, ..., 10x10] 的列表:
>>> [x * x for x in range(1, 11)]
[1, 4, 9, 16, 25, 36, 49, 64, 81, 100]

## for循环后面还可以加上if判断，这样我们就可以筛选出仅偶数的平方：
>>> [x**3 + 1 for x in range(1,10) if (x**3 +1) % 2 == 0]
[2, 28, 126, 344, 730]

### 在一个列表生成式中，for前面的if ... else是表达式，而for后面的if是过滤条件，不能带else。
>>> [x if x % 2 ==0 else -x for x in range(1, 11)]
[-1, 2, -3, 4, -5, 6, -7, 8, -9, 10]

### for 循环可以处理多个变量，所以也可以使用 多个变量生成 list ：
>>> d = {'x': 'A', 'y': 'B', 'z': 'C' }
>>> [k + '=' + v for k, v in d.items()]
['y=B', 'x=A', 'z=C']

### 转换成小写
>>> L = ['Hello', 'World', 'IBM', 'Apple']
>>> [s.lower() for s in L]
['hello', 'world', 'ibm', 'apple']
```

### 生成器

列表生成式，收到内存的限制，创建的时候肯定是有限的。

而生成器 generator 可以在循环的过程中不断的推算后续的元素。

```python
### 创建生成器
## 简单方法，只要把一个列表生成式的[]改成()
>>> L = [x * x for x in range(10)]
>>> L
[0, 1, 4, 9, 16, 25, 36, 49, 64, 81]
>>> g = (x * x for x in range(10))
>>> g
<generator object <genexpr> at 0x1022ef630>
# 通过 next() 调用下一个值。
>>> next(g)
0
>>> next(g)
1
>>> next(g)

### 使用函数生成
def fib(max):
    n, a, b = 0, 0, 1
    while n < max:
        yield b                 # 遇到yield语句返回，再次执行时从上次返回的yield语句处继续执行。
        a, b = b, a + b         # 所以不会执行 循环外的初定义。
        n = n + 1
    return 'done

>>> for n in fib(6):
...     print(n)
...
1
1
2
3
5
8
```

### 迭代器

- for 循环支持的数据类型：（统称为可迭代对象： iterable）
  - 集合数据类型：`list、tuple、dict、set、str`
  - generator：包括 生成器 和 带 `yield` 的 generation function。

可以被next()函数调用并不断返回下一个值的对象称为迭代器：Iterator

凡是可作用于for循环的对象都是Iterable类型；

凡是可作用于next()函数的对象都是Iterator类型，它们表示一个惰性计算的序列；

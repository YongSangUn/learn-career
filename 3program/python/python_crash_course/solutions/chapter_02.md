# chapter 02

## 2-1 & 2-2

```python
>>> msg = 'hello world'
>>> print(msg)
hello world
>>> msg = 'hello python'
>>> print(msg)
hello python
```

## 2-3 & 2-4

```python
>>> first_name = 'sangun'
>>> user = 'sangun'
>>>
>>> msg = 'Hi ' + user.title() + ', Welcome!'
>>> print(msg)
Hi Sangun, Welcome!
>>>
>>> print(user, user.upper(), user.lower(), user.title())
sangun SANGUN sangun Sangun
```

## 2-5 & 2-6 & 2-7

```python
>>> famous_person = '  \tlinux torvalds \n '
>>> saying = 'Talk is cheap. Show me the code.'
>>>
>>> msg = f'{famous_person.strip()} said: "{saying}"'  # %-format, python version >= 3.6, concise, better performance.
>>> msg2 = '%s said: "%s"' % (famous_person.strip(), saying)  # f-format
>>> msg3 = '{1} said: "{0}"'.format(saying, famous_person.strip())  # str.format(), way 1.
>>> msg4 = '{arg1} said: "{arg2}"'.format(arg1=famous_person.strip(), arg2=saying)  # str.format(), way 2.
>>> print(msg)
linux torvalds said: "Talk is cheap. Show me the code."
>>> msg == msg2 == msg3 == msg4
True
```

Tips:
[PEP 498 – Literal String Interpolation](https://python.org/dev/peps/pep-0498/)
[%-formatting 语句](https://docs.python.org/3/library/stdtypes.html#old-string-formatting)
[str.format() 函数](https://docs.python.org/3/library/stdtypes.html#str.format)

## 2-8 & 2-9

```python
>>> a = 1 + 7
>>> b = 10 - 2
>>> c = 2 * 4
>>> d = 16 / 2
>>> a == b == c == d == 8
True
>>> msg = f'The aswer to 1 + 6 is: {str(a)}'
>>> print(msg)
The aswer to 1 + 6 is: 8
```

## 2-10

```python
# -*- coding: utf-8 -*-
# This is a note.
print('hello world')
```

## 2-11

```python
>>> import this
The Zen of Python, by Tim Peters

Beautiful is better than ugly.
Explicit is better than implicit.
Simple is better than complex.
Complex is better than complicated.
Flat is better than nested.
Sparse is better than dense.
Readability counts.
Special cases aren't special enough to break the rules.
Although practicality beats purity.
Errors should never pass silently.
Unless explicitly silenced.
In the face of ambiguity, refuse the temptation to guess.
There should be one-- and preferably only one --obvious way to do it.
Although that way may not be obvious at first unless you're Dutch.
Now is better than never.
Although never is often better than *right* now.
If the implementation is hard to explain, it's a bad idea.
If the implementation is easy to explain, it may be a good idea.
Namespaces are one honking great idea -- let's do more of those!

# 中文翻译
优美优于丑陋，
明了优于隐晦；
简单优于复杂，
复杂优于凌乱，
扁平优于嵌套，
稀疏优于稠密，
可读性很重要！
即使实用比纯粹更优，
特例亦不可违背原则。
错误绝不能悄悄忽略，
除非它明确需要如此。
面对不确定性，
拒绝妄加猜测。
任何问题应有一种，
且最好只有一种，
显而易见的解决方法。
尽管这方法一开始并非如此直观，
除非你是荷兰人。
做优于不做，
然而不假思索还不如不做。
很难解释的，必然是坏方法。
很好解释的，可能是好方法。
命名空间是个绝妙的主意，
我们应好好利用它。
```

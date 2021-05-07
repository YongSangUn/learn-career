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

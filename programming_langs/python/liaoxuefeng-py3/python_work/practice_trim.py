# -*- coding: utf-8 -*-
'''
利用切片实现一个 trim() 函数，去除字符串首尾的空格。

- 思路还是利用循环去删除空格，
    - 最简单的方法还是利用循环将每次循环中的空格剔除
    - 使用 s[:1] 和 s[-1:]，代表每个循环中第一和最后一个元素
    - 注意单独判断特殊情况 [s = '']
'''

# while loop
def trim(s):
    if s == '':
        return s
    else:
        while s[:1] == ' ':
            s = s[1:]
        while s[-1:] == ' ':
            s = s[:-1]
        return s

# for loop
def trim(s):
    if s == '':
        return s
    else:
        for i in (1, len(s)):
            if s[:1] == ' ':
                s = s[1:]
            if s[-1:] == ' ':
                s = s[:-1]
        return s

# recursive function
def trim(s):
    '''
    递归执行 if 或者 elif 都可以。
    if 执行后 elif 是不会执行的。但因为是递归，所以使用 elif 语句时，
    当 if 语句不为true(左端空格清除完成)，会继续执行 elif (消除右端空格) 。
    '''
    if s[:1] == " ":
        return trim(s[1:])
    if s[-1:] == " ":
    #elif s[-1:] == " ":
        return trim(s[:-1])
    else:
        return s

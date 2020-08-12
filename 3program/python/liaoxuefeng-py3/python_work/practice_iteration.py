# -*- coding: utf-8 -*-
'''
请使用迭代查找一个list中最小和最大值，并返回一个tuple：
'''


def findMinAndMax(L):
    if L:
        minNum = maxNum = L[0]
        for i in L:
            if i < minNum:
                minNum = i
            if i > maxNum:
                maxNum = i
        return (minNum, maxNum)
    else:
        return (None, None)


# 测试
if findMinAndMax([]) != (None, None):
    print('测试失败!')
elif findMinAndMax([7]) != (7, 7):
    print('测试失败!')
elif findMinAndMax([7, 1]) != (1, 7):
    print('测试失败!')
elif findMinAndMax([7, 1, 3, 9, 5]) != (1, 9):
    print('测试失败!')
else:
    print('测试成功!')
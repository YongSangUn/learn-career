# -*- coding: utf-8 -*-
'''
>>> 请定义一个函数 quadratic(a, b, c)，接收3个参数，返回一元二次方程 ax^2+bx+c=0 的两个解

NOTE:
求解需要确定判别式 delta (b^2 - 4ac) 的大小:
    当 delta>0 时，方程有两个不相等的实数根；
    当 delta=0 时，方程有两个相等的实数根；
    当 delta<0 时，方程无实数根，但有2个共轭复根。 [i = (-1)^2]
'''

import math


def quadratic(a, b, c):
    delta = (b**2 - 4 * a * c)
    if a == 0:
        x = -c / b
        return '方程有唯一实根：%g' % x

    else:
        if delta == 0:
            x = -b / (2 * a)
            return '方程有唯一实根：%g' % x

        elif delta > 0:
            x1 = (-b + math.sqrt(delta)) / (2 * a)
            x2 = (-b + math.sqrt(delta)) / (2 * a)
            return '方程有 2 个实根：%g, %g' % (x1, x2)

        elif delta < 0:
            child1 = -b / (2 * a)
            child2 = math.sqrt(-delta) / (2 * a)
            x1 = ('%g + %gi' % (child1, child2))
            x2 = ('%g + %gi' % (child1, child2))
            return '方程有 2 个共轭复根：%s, %s' % (x1, x2)


print('二次方程格式：ax^2 + bx + c = 0')
a = float(input('请输入 a : '))
b = float(input('请输入 b : '))
c = float(input('请输入 c : '))

result = quadratic(a, b, c)
print(result)


# -*- coding: utf-8 -*-
'''
质数：一个大于 1 的，除了 1 和 它本身，不能被其他的自然数整除的自然数数。

使用循环，计算 [1,100] 的质数总和。
'''

# 方法一：普通循环模式，方便理解。
print("#####    方法一：普通循环    #####")
sum = 0
num = 1
# numMAX = int(input("Please enter a natural number: "))
numMAX = 20
while num <= numMAX:
    composite = False
    if num > 1:
        '''
        当输入进来一个 num：
        for 循环中会判断 num 是否为质数，用 num 循环去除以 [2,num] 集合的数，
        （当然可以除以[2,num-1] 的合集，因为是合数就会有2个因子）
        当发现能整除的数后（发现合数）：
            跳出，composire 为 True，不在执行 if not 语句。
            否则 当 for 执行完后，没有发现质数（判断值 composite 为False），则此数为质数，加入总和。

        NOTE:
            range(2,num) 表示的是 [2,num-1],
        range(2,2) 为什么不报错：
            range(2, 2)返回一个空的迭代器，for循环作用于空的迭代器上，一次也不会执行，而是直接结束。
            空迭代器是合法的，不会报错。
        '''
        for i in range(2, num):
            if (num % i == 0):
                composite = True
                print(num, "is not a prime number.")
                break

        if not composite:
            print(num, "is a prime number.")
            sum += num

    else:  # else为 num=1 的情况.
        print(num, "is not a prime number.")
    num += 1
print(sum)

# 方法二：python ，for...else 语法（while...else 语句也可以）
print("#####    方法二：for...else 语句     #####")
sum = 0
num = 1
while num <= 20:
    if num > 1:
        '''
        for 循环同上，执行的顺序是：
            for 循环通过 break 跳出后，不会执行else语句
            否则执行 for 语句后会正常执行 else 语句。
        '''
        for i in range(2, num):
            if (num % i == 0):
                print(num, "is not a prime number.")
                break

        # 当循环没有被break语句退出时，执行else语句块；else语句块作为"正常"完成循环的奖励
        else:
            print(num, "is a prime number.")
            sum += num

    else:
        print(num, "is not a prime number.")
    num += 1
print(sum)


'''
拓展：列出 100 以内的质数：
'''
print("#####    拓展：      #####")
# 一行代码实现一
print(" ".join("%s" % x for x in range(2, 100) if not [y for y in range(2, x) if x % y ==0]))

# 一行代码实现二
print([p for p in range(2,101) if not [q for q in range(2, p-1) if not p%q]])

# 埃拉托斯特尼筛法
# 链接【https://blog.csdn.net/x_i_y_u_e/article/details/46365549】
h = [True] * 100
h[:2] = [False, False]
for i in range(2, int(100**0.5) + 1):
    if h[i]:
        h[i * i::i] = [False] * len(h[i * i::i])

s = ''
for i, e in enumerate(h):
    if e:
        s += str(i) + ' '
print(s.strip())

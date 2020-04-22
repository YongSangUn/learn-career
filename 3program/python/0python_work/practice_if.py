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

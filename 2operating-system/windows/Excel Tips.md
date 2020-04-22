<span id ="jump"><font size=5>目录：</font></span>
[toc]

### 实现分母不变，分子变的除法运算

```bash
C1/$C$2
```

把分母固定就行了 这样分母就是不变的了

### 删除每列的固定字符

```bash
=RIGHT(A1,LEN(A1)-N)  
```

减去每行的固定的N个字符

### 字符串拼接

在A列中输入：

```bash
=A3&"."&B3
```

### 字符串截取

- left函数，right函数和mid函数
  - left函数语法：  
  left(text,num_chars)，从左侧开始截取部分字符串
  - right函数语法：right(text,num_chars)，从右侧开始截取部分字符串  
  其中：text表示要截取的字符串,num_chars表示要截取的字符数

  - mid函数语法：mid(text,start_num,num_chars)，中间某位置开始截取部分字符串   
  其中：text表示要截取的字符串，start_num表示从第几位字符串开始截取，num_chars表示要截取的字符数

<a href="#jump" target="_self"><p align="right">返回顶部</p></a>
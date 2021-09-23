<span id ="jump"><font size=5>目录：</font></span>
[toc]

### 用 vscode 写 markdown 的正确姿势

> 原文链接：https://blog.csdn.net/u013597671/article/details/77914638

只需要装一个预览插件神器：Markdown Preview Enhanced。
除了常规的功能外，特别要提出的是两个功能：
（1）图像
Markdown Preview Enhanced 内部支持 mermaid, PlantUML, WaveDrom, GraphViz，Vega & Vega-lite，Ditaa 图像渲染。
你也可以通过使用 Code Chunk 来渲染 TikZ, Python Matplotlib, Plotly 等图像。
（2）Code Chunk
Markdown Preview Enhanced 支持渲染代码的运行结果!!!
当你试用过 Code Chunk 之后，就知道为什么说是神器了！想想画图全部是用代码，是什么感觉？

### 设置图片大小和格式

代码：

```c
<img src="http..." width = "200" height = "140" div align=right/>
```

示例：
<img src="https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1546968706059&di=ded58bb439a47f6ae2203f07879a270a&imgtype=0&src=http%3A%2F%2F01.imgmini.eastday.com%2Fmobile%2F20180704%2F20180704163321_5d624060a28ed6b964d852f42cabc7f3_1.jpeg" width = "200" height = "140" div align=right>

> 有道云笔记好像不支持这个格式。

<a href="#jump" target="_self"><p align="right"><u>返回顶部</u></p></a>

### 设置字体-生成目录-设置锚点

> - **字体增大**
> - 用一组 `<font size=4> </font>`将全部正文内容包含进去就可以了。
> - 可以直接修改正文中的所有普通文本大小，同时不会影响标题字号。
> - 可以修改 size 自由调整大小

```c
<font size=4>
'正文内容'
</font>
```

- **生成目录**
  第一行加上 `[toc]`即可！
- **设置锚点（页内链接）**
  共两步：

> 一、创建命名锚点
>
> ```c
> 格式为 [指引到目标位置的说明文字](#目标位置的id名称)
> ```
>
> 二、创建到该命名锚点的链接
>
> ```c
> 格式为 <span id = "目标位置的id名称">跳转到的目标位置</span>
> ```
>
> 例如：

```c
<a href="#jump" target="_self">说明文字</a>

<span id ="jump"><font color="red">跳转到这里：</font></span>
```

- html 右居中:

```c
<p align="right">文字</p>
```

```
## 操作块(格式为:变量=>操作块: 备注名)
st=> start: 开始
e=>end: 结束
#普通操作块 opration
op1=>opration: 第一个操作块
op2=>opration: 第二个操作块
#判断块 condition
cond1=>condition: 第一个判断
cond2=>condition: 第二个判断

#输入输出块 inputoutput[平行四边形]
io1=>inputoutput: 输入输出块1
io2=>inputoutput: 输入输出块2
#子任务块
sub1=>subroutine: 子任务1
sub2=>subroutine: 子任务2

## 判断和位置控制
#判断流程控制
cond1(yes)->op1  #yes 的时候回到 op1
cond1(no)->e   #no 的时候 去结束

#位置指定
cond1(no)->op2(right)->op1 #控制 op2 位置置于右边，再由op2 返回 op1 (好像不能向左)
#还可以这样 cond1(no,right)
cond1(yes)->e

## 流程控制
#分着写
st->op1
op1->e

#合着写
st->op1->e

#判断也是一样：
st->cond
cond(yes)->io
cond(no)->op1
```

<a href="#jump" target="_self"><p align="right"><u>返回顶部</u></p></a>

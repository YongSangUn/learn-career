<span id ="jump"><font size=5>目录：</font></span>
[toc]

### linux中的&&和&，|和||

- &   表示任务在后台执行，如要在后台运行redis-server,则有  `redis-server & `
- &&  表示前一条命令执行成功时，才执行后一条命令 ，如 `echo ‘1‘ && echo ‘2’` 
- | 表示管道，上一条命令的输出，作为下一条命令参数，如 `echo ‘yes’ | wc -l`   
- ||   表示上一条命令执行失败后，才执行下一条命令，如 `cat nofile || echo “fail” ` 
- 分号    顺序地独立执行各条命令，彼此之间不关心是否失败， 所有命令都会执行。

### '',""和``

#### 单引号''和双引号""  

- 两者都是解决变量中间有空格的问题。

1) 单引号属于强引用，它会忽略所有被引起来的字符的特殊处理，被引用起来的字符会被原封不动的使用，唯一需要注意的点是不允许引用自身；  
2) 双引号属于弱引用，它会对一些被引起来的字符进行特殊处理，主要包括以下情况：

> 1：$加变量名可以取变量的值 ，比如：
>
> ```c
> [root@localhost ~]# echo '$PWD'
> $PWD　　
> [root@localhost ~]# echo "$PWD"
> /root
> ```
>
> 2：反引号和$()引起来的字符会被当做命令执行后替换原来的字符，比如：
>
> ```c
> [root@localhost ~]# echo '$(echo hello $(echo hello world)
> [root@localhost ~]# echo "$(echo hello world)"
> hello world
> [root@localhost ~]# echo '`echo hello world`'
> `echo hello world`
> [root@localhost ~]# echo "`echo hello world`"
> hello world
> ```
>
> 3：当需要使用字符（$  `  "  \）时必须进行转义，也就是在前面加\ ；
>
> ```c
> [root@localhost ~]# echo '$ ` " \'
> $ ` " \
> [root@localhost ~]# echo "\$ \` \" \\"
> $ ` " \
> ```
>
- 反引号``  
反引号\`\`是命令替换，命令替换是指Shell可以先执行\`\`中的命令，将输出结果暂时保存，在适当的地方输出。语法:\`command\`


<a href="#jump" target="_self"><p align="right">返回顶部</p></a>
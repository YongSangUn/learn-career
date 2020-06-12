# tips

[toc]

## '-E' 模式下不需要对大括号转义

- 匹配三个连续数字：

```c
$ grep '[0-9]\{3\}' file
# 等同于
$ grep -E '[0-9]{3}' file
# 等同于
$ egrep '[0-9]{3}' file
```

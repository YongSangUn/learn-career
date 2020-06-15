# linux 变量内容的删除、取代和替换

[toc]

## 删除

格式如下：

```bash

${<variable><cmd><regular>}

    <variable>              变量名
    <cmd>                   代表命令
    <regular>               匹配字段

- <cmd> 命令分类

    #           从头开始，删除最短匹配字段
    ##          从头开始，删除最长匹配字段
    %           从尾开始，删除最长匹配字段
    %%          从尾开始，删除最长匹配字段

```

使用环境变量示例

```bash
$ path=${PATH}
$ echo ${path}
/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/home/.local/sbin:/usr/local/games
```

- `${path#/*local/sbin:}` head, 删除最短匹配
  ~~/usr/local/sbin:~~/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/home/.local/sbin:/usr/local/games
- `${path##/*local/sbin:}` head, 删除最长匹配
  ~~/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/home/.local/sbin:~~/usr/local/games
- `${path%:*games}` tail, 删除最短匹配
  /usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/home/.local/sbin~~:/usr/local/games~~
- `${path%:*games}` tail, 删除最长匹配
  /usr/local/sbin~~:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/home/.local/sbin:/usr/local/games~~

## 取代

格式如下：

```bash
${<variable>/<regular>/<new_regular>}           # 第一个匹配字段 <regular> 替换成 <new_regular>
${<variable>//<regular>/<new_regular>}          # 所有匹配字段 <regular> 都替换成 <new_regular>

    variable            变量名
    regular             匹配字段
    new_regular         取代字段
```

同样使用环境变量示例：

- `${path/sbin/SBIN}`
  /usr/local/**SBIN**:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/home/.local/sbin:/usr/local/games
- `${path//sbin/SBIN}`
- /usr/local/SBIN:/usr/local/bin:/usr/SBIN:/usr/bin:/SBIN:/bin:/usr/games:/home/.local/SBIN:/usr/local/games

## 变量的测试与内容替换

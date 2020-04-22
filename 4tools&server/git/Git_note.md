<span id ="jump"><font size=5>目录：</font></span>

[toc]

<a href="#bottom" target="_self"><p align="right"><u>前往底部</u></p></a>

# 简介

- 创建版本库

```c
$ git init 
```

当前目录会多一个 .git/ 目录

- 提交文件

```bash
$ git status        # 使用这个命令查看文件状态
$ git add file      # file 为需要提交的文件，将文件放入暂存区
$ git commit -m "xxxx"  # '-m "xxx"' 为提交的说明，最好有意义。
```

因为commit可以一次提交很多文件，所以你可以多次add不同的文件，比如：

```c
$ git add file1.txt
$ git add file2.txt file3.txt
$ git commit -m "add 3 files."
```

# 版本管理

> 要随时掌握工作区的状态，使用 `git status` 命令。  
如果 `git status` 告诉你有文件被修改过，用 `git diff` 可以查看修改内容。  

- 更新工作区的文件，查看更新内容：

```c
$ git diff file     # 查看文件file的改动， diff 为 diffrence 的简写。
```

## 版本回退

```c
$ git log       # 查看提交的日志
$ git reset --hard HEAD     # HEAD 代表当前版本，HEAD^ 代表上一个版本，HEAD^^ 代表上上个版本，上100个版本用 HEAD~100 ，
```

- 回滚到上一个版本后，要返回最新版本

```c
$ git reflog        # 用来记录你的每一次命令，可以看到下一个版本的版本号
$ git reset --hard commit_id        # 返回指定版本，当然也可以回到未来的版本。
```

>- **小结**:
>- `HEAD` 指向的版本就是当前版本，因此，Git允许我们在版本的历史之间穿梭，使用命令 `git reset --hard commit_id`。  
>- 穿梭前，用 `git log` 可以查看提交历史，以便确定要回退到哪个版本。  
>- 要重返未来，用 `git reflog` 查看命令历史，以便确定要回到未来的哪个版本。

<a href="#jump" target="_self"><p align="right"><u>返回顶部</u></p></a>

## 工作区和暂存区

### 工作区（Working Directory）

就是你在电脑里能看到的目录

### 版本库（Repository）

工作区有一个隐藏目录 `.git` ，这个不算工作区，而是 Git 的版本库。  
Git 的版本库里存了很多东西，其中最重要的就是称为 stage （或者叫 index ）的暂存区，还有Git为我们自动创建的第一个分支  `master` ，以及指向 `master` 的一个指针叫 `HEAD` 。

![stage](https://www.liaoxuefeng.com/files/attachments/919020037470528/0)

- `git add` 命令实际上就是把要提交的所有修改放到暂存区（Stage），然后，执行 `git commit` 就可以一次性把暂存区的所有修改提交到分支。

![stage2](https://www.liaoxuefeng.com/files/attachments/919020100829536/0)

每次修改，**如果不用 `git add` 到暂存区，那就不会加入到 `commit` 中**。

## 撤销操作

- 场景1：当你改乱了工作区某个文件的内容，想直接丢弃工作区的修改时，用命令 `git checkout -- file` 。  
- 场景2：当你不但改乱了工作区某个文件的内容，还添加到了暂存区时，想丢弃修改，分两步，第一步用命令 `git reset HEAD <file>` ，就回到了场景1，第二步按场景1操作。  
- 场景3：已经提交了不合适的修改到版本库时，想要撤销本次提交，参考版本回退一节，不过前提是没有推送到远程库。

## 删除文件

- 从版本库中删除文件

```c
$ rm file && git add file && git commit -m "xxx"
$ 或者
$ git rm file && git commit -m "xxx"       
```

>小提示：先手动删除文件，然后使用 `git rm <file>` 和 `git add<file>` 效果是一样的。

- 如果删错了还没有 commit

```c
$ git checkout -- file
```

`git checkout` 其实是用版本库里的版本替换工作区的版本，无论工作区是修改还是删除，都可以“一键还原”。  
>**注意：  
从来没有被添加到版本库就被删除的文件，是无法恢复的！**

<a href="#jump" target="_self"><p align="right"><u>返回顶部</u></p></a>

# 远程仓库

## 创建 `SSH key`

1. 个人信息

```c
$ git config --global user.name "yourname"
$ git config --global user.email“your@email.com"
```

2. 删除host文件

```c
$ rm ~/.ssh/known_hosts
```

3. 设置秘钥

```c
$ ssh-keygen -t rsa -C "your@email.com"
不管出现什么一律回车
```

4. 复制秘钥

```c
$ cd ~/.ssh， 打开id_rsa.pub文件，全选复制
```

5. github中添加秘钥  

`settings` --> `SSH and GPG keys` --> `New SSH key`，在 `key` 里面 `Ctrl + V` ， `title` 自定义就行了

6. 点击 `Add SSH key`.

## 添加远程库

- 登陆GitHub，然后，在右上角找到“Create a new repo”按钮，创建一个新的仓库  
- 本地运行以下命令关联本地库：

```c
$ git remote add origin git@github.com:username/repo_name.git 
```

- 第一次运行使用

```
$ git push -u origin master 
# 加上了-u参数，Git不但会把本地的master分支内容推送的远程新的master分支，
# 还会把本地的master分支和远程的master分支关联起来，在以后的推送或者拉取时就可以简化命令。
```

- 此后每次提交

```
git push origin master
```

## 远程库克隆

- 克隆一个仓库需要知道仓库的地址，然后使用 `git clone` 命令克隆。
- git 支持多种协议，包括 `https` ，通过 `ssh` 支持的原声 `git` 协议速度最快。
- 主要的格式为：

```
$ git clone git@github.com:users_name/repo_name.git
OR
$ git clone https://github.com/users_name/repo_name.git
```


<a href="#jump" target="_self"><p align="right"><u>返回顶部</u></p></a>

<span id="bottom"></span>











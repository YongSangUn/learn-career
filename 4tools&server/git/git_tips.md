# 换行符提交替换

```git
warning: LF will be replaced by CRLF
warning: LF will be replaced by CRLF in xxxxx
The file will have its original line endings in your working directory.
```

只需要修改配置禁用该功能即可:
`git config --global core.autocrlf false`

```bash
### Git Error – src refspec {tagname} matches more than one.

删除具有相同名字的主标签即可，

git tag -d <tagName>


### git 更改标签
git tag new old
git tag -d old
git push origin :refs/tags/old  # 删除远程的 old 标签
git push --tags


# 更新远程分支列表
git remote update origin --prune

# 查看所有分支
git branch -a

# 删除远程分支Chapater6
git push origin --delete Chapater6

# 删除本地分支 Chapater6
git branch -d  Chapater6

$ git filter-branch --index-filter "git rm -rf --cached --ignore-unmatch YOURFILENAME" HEAD
$ rm -rf .git/refs/original/
$ git reflog expire --all
$ git gc --aggressive --prune
$ git push origin master --force
$ git push --all --force
```

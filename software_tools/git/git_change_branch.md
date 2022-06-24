# Git 修改本地或远程分支名称

> 注：修改远程分支先拉下来再进行以下步骤

```git
旧分支：oldBranch
新分支：newBranch

# 先将本地分支重命名
git branch -m oldBranch newBranch

# 删除远程分支（远端无此分支则跳过该步骤）
git push --delete origin oldBranch

# 将重命名后的分支推到远端
git push origin newBranch

# 把修改后的本地分支与远程分支关联
git branch --set-upstream-to origin/newBranch
```

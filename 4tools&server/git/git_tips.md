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
```

# 7z

```powershell
"C:\Program Files\7-Zip\7z.exe" a -t7z test.7z *.exe

"C:\Program Files\7-Zip\7z.exe" x test.zip -ao[a/s/u/t] -o"c:\test"

7z a archive1.zip subdir\ ：增加subdir文件夹下的所有的文件和子文件夹到archive1.zip中，archived1.zip中的文件名包含subdir\前缀。
7z a archive2.zip .\subdir\* ：增加subdir文件夹下的所有的文件和子文件夹到archive1.zip中，archived2.zip中的文件名不包含subdir\前缀。
7z x archive.zip ：从压缩档案 archive.zip 中释放所有文件到当前文件夹。
7z x archive.zip -oc:\soft *.cpp ：从压缩档案 archive.zip 中释放 *.cpp 文件到 c:\soft 文件夹。

# a/x : 创建，添加文件|解压t
# -t{type} : 指定压缩类型
# -ao[a/s/u/t]: 解压时写入模式 [覆盖/跳过/自动重命名新文件/自动重命名旧文件]


```

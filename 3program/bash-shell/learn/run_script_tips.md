# How to use SSH to run a local shell script on a remote machine?

## 运行远程脚本

```bash
source <(curl -s http://mywebsite.com/myscript.txt)
```

应该这样做。或者，不进行您的初始重定向，即重定向标准输入。bash 使用文件名即可正常执行而无需重定向，<(command)语法提供了一个路径。

```bash
bash <(curl -s http://mywebsite.com/myscript.txt)
```

如果看一下输出，可能会更清楚 echo <(cat /dev/null)

## 免交互登录

```bash
# copy 公钥
sshpass -p pwds ssh-copy-id -i ~/.ssh/id_rsa.pub user@host -o StrictHostKeyChecking=no

# 免密登录
sshpass -p pwds ssh user@host -o StrictHostKeyChecking=no
```

## 执行脚本

如果计算机 A 是 Windows 机器，则可以将 Plink（PuTTY 的一部分）与-m 参数一起使用，它将在远程服务器上执行本地脚本。
`plink root@MachineB -m local_script.sh`

如果计算机 A 是基于 Unix 的系统，则可以使用：
`ssh root@MachineB 'bash -s' < local_script.sh`

不必将脚本复制到远程服务器即可运行它。

- 直接执行

```bash
# 注意'转义的 ENDSSH
ssh user@host <<'ENDSSH'
#commands to run on remote host
ENDSSH
```

- 可以使用此语法嵌套命令，这就是嵌套似乎起作用的唯一方式（以合理的方式）

```bash
ssh user@host <<'ENDSSH'
#commands to run on remote host
ssh user@host2 <<'END2'
# Another bunch of commands on another host
wall <<'ENDWALL'
Error: Out of cheese
ENDWALL
ftp ftp.secureftp-test.com <<'ENDFTP'
test
test
ls
ENDFTP
END2
ENDSSH
```

您实际上可以与某些服务（例如 telnet，f​​tp 等）进行对话。
但是请记住，**heredoc 只是将 stdin 作为文本发送，它不等待行之间的响应**。

- 传入参数

```bash
ssh user@host ARG1=$ARG1 ARG2=$ARG2 'bash -s' <<'ENDSSH'
  # commands to run on remote host
  echo $ARG1 $ARG2
ENDSSH
```

## 免交互执行脚本

```bash
sshpass -p pwds ssh user@host -p port -o StrictHostKeyChecking=no <<'ENDSSH'
#commands to run on remote host
ENDSSH
```

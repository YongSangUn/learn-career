# github set proxy

Use proxy to accelerate clone speed of github.

Original Link: [GitHub 为什么连接缓慢以及解决方法](https://www.cclliang.com/2020/08/08/GitHub%E4%B8%BA%E4%BB%80%E4%B9%88%E8%BF%9E%E6%8E%A5%E7%BC%93%E6%85%A2%E4%BB%A5%E5%8F%8A%E8%A7%A3%E5%86%B3%E6%96%B9%E6%B3%95/)

Port `1080` need to fill in the port number used by your proxy software, mine is `7890`(clash for windows).

```cmd
# set ss
git config --global http.proxy socks5://127.0.0.1:1080
git config --global https.proxy socks5://127.0.0.1:1080

# set proxy
git config --global https.proxy http://127.0.0.1:1080
git config --global https.proxy https://127.0.0.1:1080

# cancel proxy
git config --global --unset http.proxy
git config --global --unset https.proxy

# proxy gitHub only
git config --global http.https://github.com.proxy https://127.0.0.1:1080
git config --global https.https://github.com.proxy https://127.0.0.1:1080
```

- simply use the following command:

```cmd
git config --global http.proxy socks5://127.0.0.1:1080
```

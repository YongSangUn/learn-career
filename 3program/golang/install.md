# vscode go 部署

```go
https://www.liwenzhou.com/posts/Go/00_go_in_vscode/

# 在此之前请先设置GOPROXY，打开终端执行以下命令
go env -w GOPROXY=https://goproxy.cn,direct

vscode 中 F1 输入：
> go:install



#工具详情查看
https://github.com/golang/vscode-go/blob/master/docs/tools.md#gocode

# 语言服务器， version > V1.12
go get -u -v golang.org/x/tools/gopls

# 调试工具安装
// go get -u -v github.com/go-delve/delve/cmd/dlv

# 其他的模块
// go get -u -v github.com/stamblerre/gocode
// go get -u -v github.com/uudashr/gopkgs/cmd/gopkgs
// go get -u -v github.com/ramya-rao-a/go-outline
// go get -u -v github.com/newhook/go-symbols
// go get -u -v github.com/haya14busa/goplay
// go get -u -v github.com/fatih/gomodifytags
// go get -u -v github.com/josharian/impl
// go get -u -v github.com/cweill/gotests/..
// go get -u -v github.com/davidrjenni/reftools/cmd/fillstruct


# VScode 安装go插件失败，三条命令
mkdir -p $env:GOPATH/src/golang.org/x/
cd $env:GOPATH/src/golang.org/x/
git clone https://github.com/golang/tools.git
```

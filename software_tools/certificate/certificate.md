# certificate

PKCS 全称是 Public-Key Cryptography Standards ，是由 RSA 实验室与其它安全系统开发商为促进公钥密码的发展而制订的一系列标准，PKCS 目前共发布过 15 个标准。 常用的有：

1. PKCS#7 Cryptographic Message Syntax Standard
2. PKCS#10 Certification Request Standard
3. PKCS#12 Personal Information Exchange Syntax Standard

X.509 是常见通用的证书格式。所有的证书都符合为 Public Key Infrastructure (PKI) 制定的 ITU-T X509 国际标准。

1. PKCS#7 常用的后缀是： .P7B .P7C .SPC
2. PKCS#12 常用的后缀有： .P12 .PFX
3. X.509 DER 编码(ASCII)的后缀是： .DER .CER .CRT
4. X.509 PAM 编码(Base64)的后缀是： .PEM .CER .CRT
5. .cer/.crt 是用于存放证书，它是 2 进制形式存放的，不含私钥。
6. .pem 跟 crt/cer 的区别是它以 Ascii 来表示。
7. pfx/p12 用于存放个人证书/私钥，他通常包含保护密码，2 进制方式
8. p10 是证书请求
9. p7r 是 CA 对证书请求的回复，只用于导入
10. p7b 以树状展示证书链(certificate chain)，同时也支持单个证书，不含私钥。

## 证书格式介绍

PEM 格式

> PEM 格式是证书颁发机构颁发证书的最常见格式。PEM 证书通常有诸如.pem、.crt、.cer 和.key 等扩展名。它们是 Base64 编码的 ASCII 文件，包含"-----BEGIN CERTIFICATE-----"和"-----END CERTIFICATE-----"语句。服务器证书、中间证书和私钥都可以放到 PEM 格式中。
> Apache 和其他类似的服务器都使用 PEM 格式的证书。几个 PEM 证书，甚至是私钥，都可以包含在一个文件中，一个低于另一个，但是大多数平台，比如 Apache，希望证书和私钥是在单独的文件中。

DER 格式

> DER 格式只是证书的二进制形式，而不是 ASCII PEM 格式。它的文件扩展名有时是.der，但它的文件扩展名通常是.cer，所以区分 DER .cer 文件和 PEM .cer 文件的唯一方法是用文本编辑器打开它，并查找 BEGIN/END 语句。所有类型的证书和私钥都可以用 DER 格式编码。DER 通常用于 Java 平台。SSL 转换器只能将证书转换为 DER 格式。如果你需要将私钥转换为 DER 格式，请使用本页的 OpenSSL 命令。

PKCS#7/P7B 格式

> PKCS#7 或 P7B 格式通常以 Base64 ASCII 格式存储，文件外延为.p7b 或.p7c。P7B 证书包含"-----BEGIN PKCS7-----"和"-----END PKCS7-----"语句。一个 P7B 文件只包含证书和链式证书，不包含私钥。一些平台支持 P7B 文件，包括 Microsoft Windows 和 Java Tomcat。

PKCS#12/PFX 格式

> PKCS#12 或 PFX 格式是一种二进制格式，用于在一个可加密的文件中存储服务器证书、任何中间证书和私钥。PFX 文件的扩展名通常为.pfx 和.p12。PFX 文件通常在 Windows 机器上用于导入和导出证书和私钥。
> 当将 PFX 文件转换为 PEM 格式时，OpenSSL 会将所有证书和私钥放入一个文件中。你需要在文本编辑器中打开该文件，并将每个证书和私钥(包括 BEGIN/END 状态)复制到自己单独的文本文件中，并分别保存为 certificate.cer、CACert.cer 和 privateKey.key。

## 转换命令

> 手册页 <https://www.openssl.org/docs/man1.0.2/man1/req.html>

```linux
### 查看内容
$ openssl xxx(view-format) -in xxx.xxx(key or cert file) -noout -text

# 查看 KEY
$ openssl rsa -noout -text -in server.key

# 查看 CSR、证书
$ openssl [ req | x509 ] -noout -text -in service.[ csr | ( crt | cer | pem )]

### 简单证书转换
$ openssl DER|PEM(out-format) -inform DER|PEM(in-format) \
    -in certificate.xxx(in-suffixName) -out certificate.xxx(out-suffixName)

### 示例

```

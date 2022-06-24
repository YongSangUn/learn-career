# 下载所需的包

```shell
# python 部分
python-backports-1.0-8.el7.x86_64.rpm

python-backports-ssl_match_hostname-3.5.0.1-1.el7.noarch.rpm 
python-ipaddress-1.0.16-2.el7.noarch.rpm 
python-setuptools-0.9.8-7.el7.noarch.rpm 
python-urlgrabber-3.10-9.el7.noarch.rpm 
python-2.7.5-76.el7.x86_64.rpm 
python-iniparse-0.4-9.el7.noarch.rpm 
python-libs-2.7.5-76.el7.x86_64.rpm 
python-devel-2.7.5-76.el7.x86_64.rpm 
rpm-4.11.3-35.el7.x86_64.rpm  
rpm-python-4.11.3-35.el7.x86_64.rpm

# yum 部分
yum-3.4.3-161.el7.centos.noarch.rpm 
yum-metadata-parser-1.1.4-10.el7.x86_64.rpm 
yum-plugin-fastestmirror-1.1.31-50.el7.noarch.rpm 
```

http://mirrors.163.com/centos/7.7.1908/os/x86_64/Packages/

http://mirrors.163.com/centos/7.7.1908/os/x86_64/Packages/python-backports-1.0-8.el7.x86_64.rpm
http://mirrors.163.com/centos/7.7.1908/os/x86_64/Packages/python-pycurl-7.19.0-19.el7.x86_64.rpm
http://mirrors.163.com/centos/7.7.1908/os/x86_64/Packages/python-setuptools-0.9.8-7.el7.noarch.rpm
http://mirrors.163.com/centos/7.7.1908/os/x86_64/Packages/python-urlgrabber-3.10-9.el7.noarch.rpm
http://mirrors.163.com/centos/7.7.1908/os/x86_64/Packages/python-2.7.5-86.el7.x86_64.rpm
http://mirrors.163.com/centos/7.7.1908/os/x86_64/Packages/python-iniparse-0.4-9.el7.noarch.rpm
http://mirrors.163.com/centos/7.7.1908/os/x86_64/Packages/python-libs-2.7.5-86.el7.x86_64.rpm
http://mirrors.163.com/centos/7.7.1908/os/x86_64/Packages/python-devel-2.7.5-86.el7.x86_64.rpm
http://mirrors.163.com/centos/7.7.1908/os/x86_64/Packages/rpm-4.11.3-40.el7.x86_64.rpm
http://mirrors.163.com/centos/7.7.1908/os/x86_64/Packages/rpm-python-4.11.3-40.el7.x86_64.rpm

http://mirrors.163.com/centos/7.7.1908/os/x86_64/Packages/yum-3.4.3-163.el7.centos.noarch.rpm
http://mirrors.163.com/centos/7.7.1908/os/x86_64/Packages/yum-metadata-parser-1.1.4-10.el7.x86_64.rpm
http://mirrors.163.com/centos/7.7.1908/os/x86_64/Packages/yum-plugin-fastestmirror-1.1.31-52.el7.noarch.rpm

rpm --replacefiles --replacepkgs -ivh python-2.7.5-86.el7.x86_64.rpm python-backports-1.0-8.el7.x86_64.rpm python-devel-2.7.5-86.el7.x86_64.rpm python-iniparse-0.4-9.el7.noarch.rpm python-libs-2.7.5-86.el7.x86_64.rpm python-pycurl-7.19.0-19.el7.x86_64.rpm python-setuptools-0.9.8-7.el7.noarch.rpm python-urlgrabber-3.10-9.el7.noarch.rpm rpm-4.11.3-40.el7.x86_64.rpm rpm-python-4.11.3-40.el7.x86_64.rpm
rpm --replacefiles --replacepkgs -ivh yum-3.4.3-163.el7.centos.noarch.rpm yum-metadata-parser-1.1.4-10.el7.x86_64.rpm yum-plugin-fastestmirror-1.1.31-52.el7.noarch.rpm
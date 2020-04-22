#!/bin/bash

yum install gcc zlib-devel bzip2 bzip2-devel readline-devel \
sqlite sqlite-devel openssl-devel tk-devel libffi-devel git -y

# 克隆到家目录
git clone https://github.com/pyenv/pyenv.git ~/.pyenv
#curl https://pyenv.run | bash
#exec $SHELL

# 添加环境变量
if [ $? -eq 0 ];then
    echo -e '\n# pyenv 环境变量' >> ~/.bash_profile
    echo 'export PYENV_ROOT="$HOME/.pyenv"' >> ~/.bash_profile
    echo 'export PATH="$PYENV_ROOT/bin:$PATH"' >> ~/.bash_profile
    echo 'eval "$(pyenv init -)"' >> ~/.bash_profile
    echo -e 'if command -v pyenv 1>/dev/null 2>&1; then\n  eval "$(pyenv init -)"\nfi' >> ~/.bash_profile    
    # 刷新文件配置
    echo "***** 已添加环境变量*****" && sleep 5 
    source ~/.bash_profile
    echo "***** python 版本管理工具 pyenv 已安装到 $HOME/.pyenv 目录。******"
    pyenv || source ~/.bash_profile
    pyenv versions
    #pyenv install 3.8.0
       
else
    exit
fi

# ansible install

```bash
yum install zlib zlib-devel openssl openssl-devel gcc -y
pip install paramiko PyYAML Jinja2 httplib2 six pycrypto markupsafe ecdsa simplejson

wget https://releases.ansible.com/ansible/ansible-2.9.15.tar.gz
tar xzf ansible-2.9.15.tar.gz
cd ansible-2.9.15
python setup.py install

# 创建Ansible配置文件，并开启Ansible日志(Ansible默认不启用日志)：

mkdir /etc/ansible
cp -a /tools/ansible-2.9.5/examples/ansible.cfg /etc/ansible/
sed -i.bak 's/#log_path/log_path/' /etc/ansible/ansible.cfg


# 生成密钥对
ssh-keygen -t rsa -b 1024
ssh-copy-id -i ~/.ssh/id_rsa.pub zsy@10.1.0.3 -p 22222


```

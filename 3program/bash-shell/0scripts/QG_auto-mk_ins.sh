#!/bin/bash

# 获取变量的函数，方便后续调用。
get_var(){
    # 获取第 $i 行的第 $1 个数据，$1 为传入的第一个参数。
    var=`awk -v nu=$1 'NR=="'"$i"'" {print $nu}' $file`
}

# 获取 配置信息和操作系统的函数，并转化为具体执行的名字。 
get_cpu_os(){
    get_var 1 ;cpu_arm=$var     # 获取配置,转换为对应的执行文件
    if [ $cpu_arm -eq 2 ] ;then     # 判断类型
        cpu_arm=${list_cpu_arm[0]}
        put_cpu_arm="[2核4G]"   # 定义输出名字
    elif [ $cpu_arm -eq 4 ] ;then
        cpu_arm=${list_cpu_arm[1]}
        put_cpu_arm="[4核8G]"
    elif [ $cpu_arm -eq 8 ] ;then
        cpu_arm=${list_cpu_arm[2]}
        put_cpu_arm="[8核16G]"
    fi
    get_var 2 ;os=$var          # 获取操作系统，转换为镜像id。
    if [ $os == "win" ] ;then
        os=${list_os[0]}
        put_os="[Windows-Server2016]" 
    elif [ $os == "linux" ] ;then
        os=${list_os[1]}
        put_os="[Centos-7.6]"
    fi
}

# 执行创建文件的函数
mk_instance(){
    i=1             # 从第 1 行读取文本，不可更改。
    put_num=1       # 正在创建的机器
    # 循环读取文本，获取配置。
    while read line ;do
        get_cpu_os 
        get_var 3 ;ip=$var
        get_var 4 ;server_type=$var
        get_var 5 ;name=$var
        get_var 6 ;mk_num=$var
        # 需要定义第一台机器 IP 的第四位，然后再此基础上在加 $n ，创建剩余的机器。
        ip_4_var=`echo $ip | awk -F. '{print $4}'`
        for n in $(seq 1 $mk_num) ;do
            ip_4=`expr $ip_4_var + $n - 1`      # -1 是因为，要从第一台机器创建。
            # 创建 hostname 需要 IP 的 3,4 位，并转换为标准输出的6位数字。
            # 例如 10.10.11.12 ，需要提取 011012 .
            ip_34=`echo $ip | awk -F. -v ip_4=$ip_4 '{printf("%.3d%.3d\n",$3,ip_4)}'`
            ip=`echo $ip | awk -F. -v ip_4=$ip_4 '{printf("%d.%d.%d.%d\n",$1,$2,$3,ip_4)}'`
            hostname="QG"${ip_34}${server_type}${name}
            echo "***** 正在创建第 $put_num 台机器 *****"
            echo "***** 名字:$server_type$name 配置:$put_cpu_arm 操作系统:$put_os IP:[$ip] *****"
            echo "python $cpu_arm $os $ip $hostname"        # 测试输出正确
            # 开始创建机器
            #python $cpu_arm $os $ip $hostname
            echo -e "----- ----- ----- ----- -----\n"
            let put_num+=1      # 已创建 计数
        done
        let i+=1
    done < $file
}
# 方便 配置和镜像 填写，所以转换下名字。
list_cpu_arm=(two_core.py four_core.py eight_core.py)
# win2016 : img-9id7emv7,  centos7.6 : img-9qabwvbn .
list_os=(img-9id7emv7 img-9qabwvbn)

# 需要手动编辑创建的文本,每行代表不同的机器，格式为： 
# 2 win 10.10.10.10 X testI 4

# 意为创建 2核4G IP段为 10.10.10.10-13，名字为 XtestI 的四台机器。
file="a.txt"
# 删除空行
sed -i '/^$/d' $file

# 执行函数
mk_instance 



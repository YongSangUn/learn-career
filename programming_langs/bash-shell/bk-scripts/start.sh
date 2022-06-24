#!/bin/bash

cd ${BASH_SOURCE%/*}

red_echo ()      { echo -e "\033[031;1m$@\033[0m"; }
blue_echo ()     { echo -e "\033[034;1m$@\033[0m"; }
green_echo ()    { echo -e "\033[032;1m$@\033[0m"; }

get_win_lanip () {
    ipconfig | awk '/IP(v4)? Address/{
               split($NF, N, ".")
               if ($NF ~ /^192.168/) {
                   print $NF
               }
               if (($NF ~ /^172/) && (N[2] >= 16) && (N[2] <= 31)) {
                   print $NF
               }
               if ($NF ~ /^10\./) {
                   print $NF
               }
        }'
}

get_lan_ip () {
   #
   ip addr | \
       awk -F'[ /]+' '/inet/{
               split($3, N, ".")
               if ($3 ~ /^192.168/) {
                   print $3
               }
               if (($3 ~ /^172/) && (N[2] >= 16) && (N[2] <= 31)) {
                   print $3
               }
               if ($3 ~ /^10\./) {
                   print $3
               }
          }'

   return $?
}


log () {
     # 打印消息, 并记录到日志, 日志文件由 LOG_FILE 变量定义
     local retval=$?
     local timestamp=$(date +%Y%m%d-%H%M%S)
     local level=INFO
     local func_seq=$(echo ${FUNCNAME[@]} | sed 's/ /-/g')
     local logfile=${LOG_FILE:=/tmp/bkc.log}
   
     local opt=

     if [ "${1:0:1}" == "-" ]; then
          opt=$1
          shift 1
     else
          opt=""
     fi

     echo -e $opt "[$(blue_echo $LAN_IP)]$timestamp $BASH_LINENO   $@"
     echo -e $opt "[$(blue_echo $LAN_IP)]$timestamp $level|$BASH_LINENO|${func_seq} $@" >>$logfile

     return $retval
}

usage () {
    echo "usage: $0 PLUGIN_NAME"
    exit 0
}

_status_windows_proc () {
    local proc="$1"

    pids=( $(ps -efW | grep "${proc}.exe" | awk '{print $2}') )
    echo -n ${pids[@]}
}

_status_linux_proc () {
    local proc="$1"
    local pids

    pids=($(ps -ef | grep "${proc} -c.*/${proc}.conf" | grep -v grep | awk '{print $2}'))
    echo -n ${pids[@]}

    [ ${#pids[@]} -ne 0 ]
}

_status () {
    local proc="$1"

    _status_${os_type}_proc $proc
}

case $(uname -s) in
    *Linux) os_type=linux; export LAN_IP=$(get_lan_ip | head -1) ;;
    *CYGWIN*) os_type=windows; export LAN_IP=$(get_win_lanip | head -1) ;;
esac

[ -z "$1" ] && usage

log -n "start $1 ..."
if [ -f $1 ]; then
    chmod +x ./$1
else
    red_echo "$1: file not exists($PWD)"
    exit 1
fi

if [ -f ../etc/${1}.conf ]; then
    nohup ./$1 -c ../etc/${1}.conf >/dev/null 2>/tmp/xuoasefasd.err &
    sleep 1
    if _status $1; then
        green_echo "Done"
    else
        red_echo "$(< /tmp/xuoasefasd.err). Fail"
        exit 1
    fi
else
    red_echo "config file ${1}.conf not exists"
    exit 1
fi

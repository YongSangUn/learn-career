#!/bin/bash
######################################################################
#This is an example of using getopts in Bash. It also contains some
#other bits of code I find useful.
#Author: Linerd
#Website: http://tuxtweaks.com/
#Copyright 2014
#License: Creative Commons Attribution-ShareAlike 4.0
#http://creativecommons.org/licenses/by-sa/4.0/legalcode
######################################################################
#Set Script Name variable
SCRIPT=$(basename ${BASH_SOURCE[0]})
#Initialize variables to default values.
OPT_A=A
OPT_B=B
OPT_C=C
OPT_D=D
#Set fonts for Help.[译注: 这里tput用来更改终端文本属性,比如加粗，高亮等]
NORM=$(tput sgr0)
BOLD=$(tput bold)
REV=$(tput smso)
#Help function
function HELP() {
    echo -e \\n"Help documentation for ${BOLD}${SCRIPT}.${NORM}"\\n
    echo -e "${REV}Basic usage:${NORM} ${BOLD}$SCRIPT file.ext${NORM}"\\n
    echo "Command line switches are optional. The following switches are recognized."
    echo "${REV}-a${NORM} --Sets the value for option ${BOLD}a${NORM}. Default is ${BOLD}A${NORM}."
    echo "${REV}-b${NORM} --Sets the value for option ${BOLD}b${NORM}. Default is ${BOLD}B${NORM}."
    echo "${REV}-c${NORM} --Sets the value for option ${BOLD}c${NORM}. Default is ${BOLD}C${NORM}."
    echo "${REV}-d${NORM} --Sets the value for option ${BOLD}d${NORM}. Default is ${BOLD}D${NORM}."
    echo -e "${REV}-h${NORM} --Displays this help message. No further functions are performed."\\n
    echo -e "Example: ${BOLD}$SCRIPT -a foo -b man -c chu -d bar file.ext${NORM}"\\n
    exit1
}
#Check the number of arguments. If none are passed, print help and exit.
NUMARGS=$#
echo -e \\n"Number of arguments: $NUMARGS"
if [ $NUMARGS -eq 0 ]; then
    HELP
fi
### Start getopts code ###
#Parse command line flags
#如果选项需要后跟参数，在选项后面加":"
#注意"-h"选项后面没有":"，因为他不需要参数。选项字符串最开始的":"是用来去掉来自getopts本身的报错的，同时获取不能识别的选项。（译注：如果选项字符串不以":"开头，发生错误（非法的选项或者缺少参数）时，getopts会向错误输出打印错误信息；如果以":"开头，则不会打印[在man中叫slient error reporting]，同时将出错的选项赋给OPTARG变量）
while getopts :a:b:c:d:h FLAG; do
    case $FLAG in
        a) #set option "a"
            OPT_A=$OPTARG
            echo "-a used: $OPTARG"
            echo "OPT_A = $OPT_A"
            ;;
        b) #set option "b"
            OPT_B=$OPTARG
            echo "-b used: $OPTARG"
            echo "OPT_B = $OPT_B"
            ;;
        c) #set option "c"
            OPT_C=$OPTARG
            echo "-c used: $OPTARG"
            echo "OPT_C = $OPT_C"
            ;;
        d) #set option "d"
            OPT_D=$OPTARG
            echo "-d used: $OPTARG"
            echo "OPT_D = $OPT_D"
            ;;
        h) #show help
            HELP
            ;;
        \?) #unrecognized option - show help
            echo -e \\n"Option -${BOLD}$OPTARG${NORM} not allowed."
            HELP
            #在这里如果你不想打印完整的帮助信息，只想显示简单的错误信息，去掉上面的两行，同时使用下面的两行。
            #echo -e "Use ${BOLD}$SCRIPT -h${NORM} to see the help documentation."\\n
            #exit 2
            ;;
    esac
done
shift $((OPTIND - 1)) #This tells getopts to move on to the next argument.
### End getopts code ###
### Main loop to process files ###
#这里你可以用你的脚本处理逻辑来替代。这个例子只是在终端中打印文件的文件名和后缀名。你可以把任意其他的文件处理任务放到这个while-do循环中。
while [ $# -ne 0 ]; do
    FILE=$1
    TEMPFILE=$(basename $FILE)
    #TEMPFILE="${FILE##*/}" #另外一种获取不带后缀的文件名的方法。
    FILE_BASE=$(echo "${TEMPFILE%.*}") #file without extension
    FILE_EXT="${TEMPFILE##*.}"         #file extension
    echo -e \\n"Input file is: $FILE"
    echo "File withouth extension is: $FILE_BASE"
    echo -e "File extension is: $FILE_EXT"\\n
    shift #Move on to next input file.
done
### End main loop ###
exit0

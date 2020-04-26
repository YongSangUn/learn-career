#!/bin/bash

filename="dump`date +%Y%m%d%H%M`.hprof"

# get tomcat_id
tomcat_id=`jps -l | grep apache | awk '{print $1}'`
echo "tomcat_id:"$tomcat_id

# dump
echo "开始抓取dump..."
jmap -dump:live,format=b,file=$filename $tomcat_id \
	&& echo "抓取完成，开始压缩..."

# compressing & mv file to /root/dump/
tar -zcf $filename".tgz" $filename && rm $filename -f
mv $filename* /root/dump/ && echo "压缩完成，原始文件已删除，压缩文件放至 /root/dump/ 目录。"
echo "保存文件..." && sleep 3s
sz /root/dump/$filename".tgz"
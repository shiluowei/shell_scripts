#!/bin/bash
#author:shiluowei
#date:2016-12-24
#intro:
#自动进行初步yum安装所需要的插件，自动更新yum源
#配置ssh登录用户为admin，设置sudo权限

source ./alert.sh
source ./functions.sh
#判断当前登录用户是否是root，只有root才有
#权限执行该脚本
ifRoot
echo "开始yum安装所需要的插件"
yum instal -y net-tools vim >> /dev/null  2>&1
#调用functions.sh中的result函数
result "执行yum失败"
echo "更新yum源"
yumSource_path=/etc/yum.repos.d

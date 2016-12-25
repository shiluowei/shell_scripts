#!/bin/bash
#author:shiluowei
#date:2016-12-24
#intro:
#自动进行初步yum安装所需要的插件，自动更新yum源
#配置ssh登录用户为admin，设置sudo权限

function optimization() {

	#判断当前登录用户是否是root，只有root才有
	#权限执行该脚本
	ifRoot
	echo "开始yum安装所需要的插件"
	yum install -y net-tools vim >> /dev/null  2>&1
	#调用functions.sh中的result函数
	result "执行yum失败"  "执行yum成功" 
	echo "开始更新yum源"
	mkdir ${yumSourcePathBackup}
	mv ${yumSourcePath}/*.repo ${yumSourcePathBackup}
	cd ./src && cp  ./163.repo ${yumSourcePath} && cd ../
	(yum clean all  && yum makecache  && yum upgrade -y) >> /dev/null 2>&1 
	result "执行yum更新源和更新失败" "执行yum更新源和更新成功"
	echo "创建admin用户"
	useradd luoweis
	echo "luoweis:@dmin123456" | chpasswd
	yum install -y sudo >> /dev/null 2>&1
	echo "luoweis   ALL=(root) ALL, !/usr/bin/passwd [A-Za-z]*, !/usr/bin/passwd   root" >> /etc/sudoers
	result "添加luoweis sudo权限失败" "添加luoweis sudo权限成功"
	#修改sshd的默认22端口为2222端口
	sed -i "s/\#Port 22/Port 2222/g"  ${sshConfigPath}
	systemctl restart sshd
	result "配置ssh失败" "配置ssh成功"
	lock optimization
	result "创建锁文件失败" "创建锁文件,自动优化过程结束"
}









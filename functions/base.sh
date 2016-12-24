#!/bin/bash
#这个方法是用来判断执行脚本的用户是否是root
function ifRoot() {
	if [ $UID -ne 0 ]
	then 
		echo -e  "${RED_COLOR}当前用户为普通用户，需要切换root用户执行该脚本${RES}"
		exit 2
	fi
}

#这个方法是用来判断上一步执行的正确与否。
function result() {
	if [ $? -ne 0 ]
	then 
		echo -e  "${RED_COLOR}$1${RES}"
		exit 1
	else
		echo -e "${GREEN_COLOR}$2${RES}"
	fi
}

#设置一个锁的函数方法，用来测试自动化脚本是否成功安装过
function lock() {
	if [ -f ./lock/$1.lock ]
	then
		echo -e  "${RED_COLOR}$1已经安装过${RES}"
		exit 3
	else
		echo -e "${GREEN_COLOR}$1开始安装${RES}"
	fi
}

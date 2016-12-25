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

#创建一个锁函数
function lock() {
	cd ${startPath}
	if [ -d ./lock ]
		then
			cd ./lock && touch $1.lock && cd ../
		else
			mkdir ./lock && cd ./lock && touch $1.lock && cd ../
	fi
	
}
#设置一个判断时候有锁文件的函数方法，用来测试自动化脚本是否成功安装过
function ifLock() {
	if [ -f ./lock/$1.lock ]
	then
		echo -e  "${RED_COLOR}$1已经安装过${RES}"
		exit 3
	else
		echo -e "${GREEN_COLOR}$1开始安装${RES}"
	fi
}

function removeLock() {
	cd ${startPath}
	rm -rf ./lock/$1.lock
}

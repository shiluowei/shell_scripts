#!/bin/bash
source ./alert.sh

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
	fi
}
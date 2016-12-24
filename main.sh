#!/bin/bash
#autor:
#date:
#intro:
#自动执行脚本的主函数
source ./functions/color.sh
source ./functions/base.sh
source ./conf/conf.sh
echo -e  "${YELOW_COLOR}选择自动化程序的选项${RES}"
echo -e  "${YELOW_COLOR}1:自动进行优化系统${RES}"
echo -e  "${YELOW_COLOR}2:自动安装OpenResty${RES}"
echo -e  "${YELOW_COLOR}3:自动安装Mariadb_10.1.19${RES}"
read -t 10 -p "输入选择项："  choose

case "$choose" in
	1)
		
		lock optimization 
		source ./auto_optimization/optimization.sh
		optimization

;;
	2)
		echo "开始自动安装OpenResty"
;;
	3)
		echo "开始自动安装Mariadb"
;;
	'')
		echo "未做任何选择"
;;
	*)
		echo "选择的输入数字不正确"
esac
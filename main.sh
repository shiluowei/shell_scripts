#!/bin/bash
#autor:
#date:
#intro:
#自动执行脚本的主函数

startPath=`pwd`
source ./functions/color.sh
source ./functions/base.sh
source ./conf/conf.sh
ifRoot
case "$1" in
	"install")
		echo -e  "${YELOW_COLOR}选择自动化程序的选项${RES}"
		echo -e  "${YELOW_COLOR}1:自动进行优化系统${RES}"
		echo -e  "${YELOW_COLOR}2:自动安装OpenResty${RES}"
		echo -e  "${YELOW_COLOR}3:自动安装Mariadb_10.1.19${RES}"
		read -t 10 -p "输入选择项："  choose

		case "$choose" in
			1)
				#自动优化
				ifLock optimization 
				source ./scripts/optimization.sh
				optimization

		;;
			2)
				echo -e  "${YELOW_COLOR}1:OpenResty 最新版本${RES}"
				echo -e  "${YELOW_COLOR}2:OpenResty 1.9.7.4${RES}"
				read -t 10 -p "输入选择项："  version
				case "$version" in
					1)
						#安装openresty最新版本
						ifLock openresty_init
						source ./scripts/openresty_init.sh 
						openresty_init openresty-1.11.2.2.tar.gz
					;;
					2)
						#安装openresty 1.9.7
						ifLock openresty_init
						source ./scripts/openresty_init.sh 
						openresty_init openresty-1.9.7.4.tar.gz
					;;
					'')
						echo "未做任何版本选择"
						exit 2
					;;
					*)
						echo "选择的输入数字不正确"	
				esac
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
	;;

	"remove")
		echo -e  "${RED_COLOR}选择删除程序的选项${RES}"
		echo -e  "${RED_COLOR}1:删除OpenResty${RES}"
		echo -e  "${RED_COLOR}2:删除Mariadb_10.1.19${RES}"
		read -t 10 -p "输入选择项："  choose
		case "$choose" in
			1)
				source ./scripts/openresty_init.sh
				remove
			;;
			2)
				echo "删除Mariadb_10.1.19"
			;;
			'')
				echo "未做任何选择"
			;;
			*)
				echo "选择的输入数字不正确"
		esac
	;;

	*)
		echo "使用方法 ／bin/bash $0 install|remove"
esac
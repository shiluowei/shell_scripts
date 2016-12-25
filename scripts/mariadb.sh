#!/bin/bash
#author:
#date:
#intro:
#自动安装Mariadb的脚本
#安装这依赖包
function mariadb() {
	yum install -y libaio* >> /dev/null 2>&1
	result "安装依赖失败，程序退出" "安装依赖成功，继续下一步"
	#添加mysql用户
	groupadd -r ${mariadbGroup}
	useradd -s /sbin/nologin -g ${mariadbGroup} -r ${mariadbUser}
	#创建目录
	mkdir -p ${mariadbSock}
	mkdir -p ${mariadbLog}
	mkdir -p ${mariadbBinlog}
	mkdir -p ${mariadbPid}
	mkdir -p ${mariadbData}
	chown -R ${mariadbUser}:${mariadbGroup} ${mariadbRoot}
	#解压并初始化mysql
	#mariadb-10.1.19-linux-x86_64.tar.gz
	version=$1
	cd ./src/data/mariadb && \
	mkdir -p ${mariadbPath} && \
	tar xfz ${version} -C ${mariadbPath}
	pwd
	(cd ${mariadbPath} &&  ln -s ${version%\.tar\.gz} mysql && \
	cd ./mysql && chown -R root:mysql . && \
	./scripts/mysql_install_db --user=${mariadbUser} --datadir=${mariadbData}) >> /dev/null 2>&1
	result "初始化数据库失败，退出程序" "初始化数据库成功，继续下一步"
	cd ${mariadbPath}/mysql
	cp ./support-files/mysql.server /etc/init.d/mysqld && cd ${startPath}
	pwd
	#提供配置文件
	cp ./src/data/mariadb/basemy.cnf /etc/my.cnf
	#启动mysql
	chkconfig --add mysqld && chkconfig mysqld on && systemctl start mysqld
	result "启动数据库失败" "启动数据库成功，现在是无密码状态"
}




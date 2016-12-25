#!/bin/bash
#autor:
#date:
#intro:
#自动安装openresty的脚本
#安装依赖软件
function openresty_init() {
	echo "开始安装openresty，请稍候片刻。。。。。。"
	startPath=`pwd`
	yum install -y readline-devel pcre-devel openssl-devel gcc make  >>/dev/null 2>&1
	result "安装依赖失败，退出安装程序" "安装依赖成功，继续下一步"
	#创建openresty的安装路径
	mkdir -p ${openrestyPath}
	#创建openresty的用户及用户组
	groupadd -r ${openrestyGroup}
	useradd -s /sbin/nologin -g ${openrestyGroup} -r ${openrestyUser}
	#解压缩到指定的目录
	tar xfz ./src/openresty/${openrestyVersion_latest} -C ${openrestyPath}
	#安装luajit
	(cd ${openRestyRoot}/bundle/LuaJIT-2.1-20161104 && \
		make clean && make && make install) >> /dev/null 2>&1
	result "openresty luajit 安装失败退出程序" "openresty luajit 安装成功，继续下一步"
	#添加插件
	cd ${startPath}
	tar xfz ./src/openresty/2.3.tar.gz -C  ${openRestyRoot}/bundle && \
	tar xfz ./src/openresty/v0.3.0.tar.gz -C ${openRestyRoot}/bundle
	result "openresty 模块添加失败退出程序" "openresty 模块添加成功，继续下一步"
	#openresty 编译
	cd ${openRestyRoot}
	echo "当前所在目录:`pwd`,开始编译"
	(./configure \
	--prefix=${openrestyPath} \
	--with-http_realip_module  \
	--with-pcre --with-luajit  \
	--add-module=./bundle/ngx_cache_purge-2.3/  \
	--add-module=./bundle/nginx_upstream_check_module-0.3.0/ && \
	make && make install) >> /dev/null 2>&1
	result "openresty 编译安装失败退出程序" "openresty 编译安装成功，继续下一步"
}




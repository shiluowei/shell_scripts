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
	echo "创建nginx项目"
	cd ${startPath}
	mkdir ${luaRoot} && cp -r ${lualibPath} ${luaRoot} && mkdir ${luaRoot}/lua && cp ./src/openresty/main.lua ${luaRoot}/lua
	cat >>${luaRoot}/wwwlua.conf<<-EOF
		server {
			listen 80;
			server_name ${server_name};
			location / {
			default_type 'text/html';
			#lua_code_cache off;
			content_by_lua_file /wwwlua/lua/main.lua;
			}
		}
	EOF
	#上传nginx.conf
	mv ${openrestyPath}/nginx/conf/nginx.conf  ${openrestyPath}/nginx/conf/nginx.conf_`date +%F:%T`
	cp ./src/openresty/nginx.conf  ${openrestyPath}/nginx/conf
	#启动nginx
	${openrestyPath}/nginx/sbin/nginx 
	result "openresty 启动失败" "openresty 启动成功"
	#创建锁文件
	cd ${startPath}
	cd ./lock && touch openresty_init.lock && cd ../
	result "创建锁文件失败" "创建锁文件成功"
}
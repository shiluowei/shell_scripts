yumSourcePath=/etc/yum.repos.d
yumSourcePathBackup=${yumSourcePath}/backup
sshConfigPath=/etc/ssh/sshd_config

#[OpenResty]
#openresty的安装路径
openrestyPath=/usr/local/newCisco/web
openrestyUser=nginx
openrestyGroup=nginx
server_name='192.168.1.80'
#openresty安装主目录
luaRoot=/wwwlua
lualibPath=${openrestyPath}/lualib

#[Mariabd]
mariadbUser=mysql
mariadbGroup=mysql
mariadbRoot=/mydata
mariadbSock=/mydata/sock
mariadbLog=/mydata/log
mariadbBinlog=/mydata/bin_log
mariadbPid=/mydata/pid
mariadbData=/mydata/data

mariadbPath=/usr/local/newCisco/data